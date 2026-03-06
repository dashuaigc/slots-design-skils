#!/usr/bin/env bash
# =============================================================================
# github-rollback.sh — 将 Skills 回退到指定历史版本
# 用法：bash github-rollback.sh <commit-hash> [--dry-run]
#
# 安全策略：
#   - 非破坏性回退：创建新提交记录回退操作，完整历史保留可追溯
#   - 凭据保护：回退后 github-config.sh 始终写入脱敏版本
#   - --dry-run：仅预览将要变更的文件，不执行任何修改
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_FILE="$SCRIPT_DIR/github-config.sh"
CONFIG_REL="scripts/github-manage/github-config.sh"

# ── 解析参数 ──────────────────────────────────────────────────────────────────
DRY_RUN=false
COMMIT_HASH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    *)
      COMMIT_HASH="$1"
      shift
      ;;
  esac
done

if [ -z "$COMMIT_HASH" ]; then
  echo "❌ 用法：bash github-rollback.sh <commit-hash> [--dry-run]"
  echo "   请提供要回退到的 commit hash"
  echo "   可先运行 github-history.sh 查看历史版本"
  exit 1
fi

# ── 读取配置 ──────────────────────────────────────────────────────────────────
if [ ! -f "$CONFIG_FILE" ]; then
  echo "❌ 错误：找不到配置文件 github-config.sh"
  exit 1
fi

source "$CONFIG_FILE"

if [ "$GITHUB_STATUS" != "configured" ]; then
  echo "❌ GitHub 尚未配置完成（状态：$GITHUB_STATUS）"
  exit 1
fi

# ── 进入仓库根目录 ────────────────────────────────────────────────────────────
cd "$REPO_ROOT"

if [ ! -d ".git" ]; then
  echo "❌ 当前目录不是 Git 仓库"
  exit 1
fi

# ── 验证目标 commit 存在 ─────────────────────────────────────────────────────
if ! git cat-file -t "$COMMIT_HASH" &>/dev/null; then
  echo "❌ 找不到提交：$COMMIT_HASH"
  echo "   请运行 github-history.sh 查看可用的版本"
  exit 1
fi

# ── 获取目标 commit 信息 ─────────────────────────────────────────────────────
TARGET_MSG=$(git log --format='%s' -1 "$COMMIT_HASH")
TARGET_DATE=$(git log --format='%ai' -1 "$COMMIT_HASH")
TARGET_SHORT=$(git log --format='%h' -1 "$COMMIT_HASH")
CURRENT_SHORT=$(git log --format='%h' -1 HEAD)

echo "=================================================="
echo "  Skills 版本回退"
echo "=================================================="
echo ""
echo "  当前版本：$CURRENT_SHORT (HEAD)"
echo "  目标版本：$TARGET_SHORT"
echo "  目标时间：$TARGET_DATE"
echo "  目标说明：$TARGET_MSG"
echo ""

# ── Dry-run 模式：仅预览差异 ─────────────────────────────────────────────────
if [ "$DRY_RUN" = true ]; then
  echo "── [预览模式] 回退将产生以下文件变更 ──────────"
  git diff --name-status HEAD "$COMMIT_HASH" -- . ':!scripts/github-manage/github-config.sh' ':!skills/nano-banana-generation/references/api-config.md'
  echo "──────────────────────────────────────────────────"
  echo ""
  echo "✅ 预览完成（未执行任何修改）"
  echo "   去掉 --dry-run 参数可执行实际回退"
  exit 0
fi

# ── 检查工作区是否干净 ────────────────────────────────────────────────────────
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "⚠️  工作区有未提交的变更，回退前需要先提交或清理"
  echo ""
  echo "── 未提交的变更 ──────────────────────────────────"
  git status --short
  echo "──────────────────────────────────────────────────"
  exit 1
fi

# ── 保存当前真实凭据 ─────────────────────────────────────────────────────────
_STATUS="$GITHUB_STATUS"
_URL="$GITHUB_REPO_URL"
_USER="$GITHUB_USERNAME"
_EMAIL="$GITHUB_EMAIL"
_BRANCH="$GITHUB_BRANCH"

# ── 解除 skip-worktree ──────────────────────────────────────────────────────
git update-index --no-skip-worktree "$CONFIG_REL" 2>/dev/null || true

# ── 回退文件到目标版本 ───────────────────────────────────────────────────────
echo "→ 回退文件到版本 $TARGET_SHORT ..."
git checkout "$COMMIT_HASH" -- .

# ── 立即恢复 github-config.sh 为脱敏版本（防止旧版凭据被提交）───────────────
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

# ── 暂存并提交 ───────────────────────────────────────────────────────────────
echo "→ 暂存变更..."
git add .

# 检查是否确实有变更
HAS_STAGED=$(git diff --cached --quiet && echo "no" || echo "yes")

if [ "$HAS_STAGED" = "no" ]; then
  echo ""
  echo "✅ 当前版本与目标版本内容相同，无需回退。"
  # 恢复本地真实配置
  cat > "$CONFIG_FILE" << REAL_NOCHANGE
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
REAL_NOCHANGE
  git update-index --skip-worktree "$CONFIG_REL" 2>/dev/null || true
  exit 0
fi

echo ""
echo "── 回退变更文件 ──────────────────────────────────"
git diff --cached --name-status
echo "──────────────────────────────────────────────────"
echo ""

ROLLBACK_MSG="回退到版本 $TARGET_SHORT: $TARGET_MSG"
git commit -m "$ROLLBACK_MSG"
echo "→ 已提交：「$ROLLBACK_MSG」"

# ── 推送到 GitHub ────────────────────────────────────────────────────────────
echo ""
echo "→ 推送到 GitHub..."
if ! git push origin "$_BRANCH" 2>/dev/null; then
  echo "→ 检测到远端有更新，正在同步..."
  git pull --rebase origin "$_BRANCH"
  git push origin "$_BRANCH"
fi

# ── 恢复本地真实配置 ─────────────────────────────────────────────────────────
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

git update-index --skip-worktree "$CONFIG_REL" 2>/dev/null || true

echo ""
echo "=================================================="
echo "  ✅ 回退完成！"
echo "  已从 $CURRENT_SHORT → $TARGET_SHORT"
echo "  回退说明：$TARGET_MSG"
echo "  仓库地址：${GITHUB_REPO_URL%.git}"
echo "  github-config.sh 已自动脱敏上传，本地真实配置已恢复"
echo "=================================================="
