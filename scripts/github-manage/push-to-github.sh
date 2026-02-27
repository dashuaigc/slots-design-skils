#!/usr/bin/env bash
# =============================================================================
# push-to-github.sh — Skills → GitHub 同步执行脚本
# 用法：bash .claude/skills/scripts/github-manage/push-to-github.sh ["提交说明"]
# 注意：必须先由 Claude Code 完成 github-config.sh 配置才能运行
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_FILE="$SCRIPT_DIR/github-config.sh"
CONFIG_REL="scripts/github-manage/github-config.sh"

# ── 读取配置 ──────────────────────────────────────────────────────────────────
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ 错误：找不到配置文件 github-config.sh"
  echo "   请通过 Claude Code 重新运行设置流程"
  exit 1
fi

source "$CONFIG_FILE"

if [ "$GITHUB_STATUS" != "configured" ]; then
  echo "❌ GitHub 尚未配置完成（状态：$GITHUB_STATUS）"
  echo "   请通过 Claude Code 运行 GitHub 设置流程"
  exit 1
fi

if [ -z "$GITHUB_REPO_URL" ]; then
  echo "❌ 仓库地址（GITHUB_REPO_URL）为空，请检查 github-config.sh"
  exit 1
fi

# ── 进入仓库根目录 ────────────────────────────────────────────────────────────
cd "$REPO_ROOT"

echo "=================================================="
echo "  Skills → GitHub 同步"
echo "  本地目录：$REPO_ROOT"
echo "  目标仓库：$GITHUB_REPO_URL"
echo "  分支：$GITHUB_BRANCH"
echo "=================================================="

# ── 初始化 Git（如尚未初始化） ───────────────────────────────────────────────
if [ ! -d ".git" ]; then
  echo "→ 初始化 Git 仓库..."
  git init
  git branch -M "$GITHUB_BRANCH"
fi

# ── 配置 Windows 凭据管理器 ───────────────────────────────────────────────────
git config --local credential.helper manager

# ── 设置提交者身份 ────────────────────────────────────────────────────────────
git config user.name "$GITHUB_USERNAME"
git config user.email "$GITHUB_EMAIL"

# ── 配置 remote origin ────────────────────────────────────────────────────────
if git remote get-url origin &>/dev/null 2>&1; then
  git remote set-url origin "$GITHUB_REPO_URL"
else
  git remote add origin "$GITHUB_REPO_URL"
fi

# ── 构建提交说明 ──────────────────────────────────────────────────────────────
TIMESTAMP=$(date "+%Y-%m-%d %H:%M")
COMMIT_MSG="${1:-"sync: $TIMESTAMP"}"

# ── 脱敏 github-config.sh 用于提交（先解除 skip-worktree）────────────────────
git update-index --no-skip-worktree "$CONFIG_REL" 2>/dev/null || true

# 保存本地真实值
_STATUS="$GITHUB_STATUS"
_URL="$GITHUB_REPO_URL"
_USER="$GITHUB_USERNAME"
_EMAIL="$GITHUB_EMAIL"
_BRANCH="$GITHUB_BRANCH"

# 写入脱敏版本（结构保留，账号信息清空）
cat > "$CONFIG_FILE" << 'SANITIZED'
#!/usr/bin/env bash
# =============================================================================
# github-config.sh — GitHub 连接状态配置文件
# 由 Claude Code 自动管理，无需手动编辑
# =============================================================================

# 状态值说明：
#   not_configured  — 尚未设置（首次使用时的初始值）
#   opted_out       — 用户选择不使用 GitHub，后续不再询问
#   configured      — 已配置完成，可正常推送

GITHUB_STATUS="not_configured"

GITHUB_REPO_URL=""        # 示例：https://github.com/username/slots-design.git
GITHUB_USERNAME=""        # 用于 git commit 署名的 GitHub 用户名
GITHUB_EMAIL=""           # 建议使用 GitHub noreply：username@users.noreply.github.com
GITHUB_BRANCH="main"
SANITIZED

# ── 暂存所有变更（包含脱敏后的 github-config.sh）──────────────────────────────
echo "→ 暂存变更..."
git add .

# ── 检查是否有新的可提交内容或未推送提交 ────────────────────────────────────────
HAS_STAGED=$(git diff --cached --quiet && echo "no" || echo "yes")
UNPUSHED=$(git log origin/"$_BRANCH"..HEAD --oneline 2>/dev/null | wc -l | tr -d ' ')

if [ "$HAS_STAGED" = "no" ] && [ "$UNPUSHED" = "0" ]; then
  # 无需推送，恢复本地真实配置
  cat > "$CONFIG_FILE" << REAL2
#!/usr/bin/env bash
# =============================================================================
# github-config.sh — GitHub 连接状态配置文件
# 由 Claude Code 自动管理，无需手动编辑
# =============================================================================

# 状态值说明：
#   not_configured  — 尚未设置（首次使用时的初始值）
#   opted_out       — 用户选择不使用 GitHub，后续不再询问
#   configured      — 已配置完成，可正常推送

GITHUB_STATUS="$_STATUS"

GITHUB_REPO_URL="$_URL"
GITHUB_USERNAME="$_USER"
GITHUB_EMAIL="$_EMAIL"
GITHUB_BRANCH="$_BRANCH"
REAL2
  git update-index --skip-worktree "$CONFIG_REL" 2>/dev/null || true
  echo ""
  echo "✅ 没有新变更，本地已与远端同步，无需推送。"
  exit 0
fi

# ── 有新文件变更则提交 ────────────────────────────────────────────────────────
if [ "$HAS_STAGED" = "yes" ]; then
  echo ""
  echo "── 本次变更文件 ──────────────────────────────────"
  git diff --cached --name-status
  echo "──────────────────────────────────────────────────"
  echo ""
  git commit -m "$COMMIT_MSG"
  echo "→ 已提交：「$COMMIT_MSG」"
  echo ""
fi

# ── 推送（若远端有更新则先 rebase 再推）────────────────────────────────────────
echo "→ 推送到 GitHub..."
if ! git push -u origin "$_BRANCH" 2>/dev/null; then
  echo "→ 检测到远端有更新，正在同步..."
  git pull --rebase origin "$_BRANCH"
  git push -u origin "$_BRANCH"
fi

# ── 推送完成：恢复本地真实配置 ───────────────────────────────────────────────
cat > "$CONFIG_FILE" << REAL
#!/usr/bin/env bash
# =============================================================================
# github-config.sh — GitHub 连接状态配置文件
# 由 Claude Code 自动管理，无需手动编辑
# =============================================================================

# 状态值说明：
#   not_configured  — 尚未设置（首次使用时的初始值）
#   opted_out       — 用户选择不使用 GitHub，后续不再询问
#   configured      — 已配置完成，可正常推送

GITHUB_STATUS="$_STATUS"

GITHUB_REPO_URL="$_URL"
GITHUB_USERNAME="$_USER"
GITHUB_EMAIL="$_EMAIL"
GITHUB_BRANCH="$_BRANCH"
REAL

# 告诉 git 忽略本地该文件的变更（保护真实值不被下次意外提交）
git update-index --skip-worktree "$CONFIG_REL" 2>/dev/null || true

echo ""
echo "=================================================="
echo "  ✅ 同步完成！"
echo "  仓库地址：${GITHUB_REPO_URL%.git}"
echo "  github-config.sh 已自动脱敏上传，本地真实配置已恢复"
echo "=================================================="
