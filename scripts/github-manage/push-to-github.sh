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

# ── 暂存所有变更 ──────────────────────────────────────────────────────────────
echo "→ 暂存变更..."
git add .

# ── 检查是否有可提交内容 ──────────────────────────────────────────────────────
if git diff --cached --quiet; then
  echo ""
  echo "✅ 没有新变更，本地已与远端同步，无需推送。"
  exit 0
fi

# ── 显示变更摘要 ──────────────────────────────────────────────────────────────
echo ""
echo "── 本次变更文件 ──────────────────────────────────"
git diff --cached --name-status
echo "──────────────────────────────────────────────────"
echo ""

# ── 提交并推送 ────────────────────────────────────────────────────────────────
git commit -m "$COMMIT_MSG"
echo "→ 已提交：「$COMMIT_MSG」"
echo ""
echo "→ 推送到 GitHub..."
git push -u origin "$GITHUB_BRANCH"

echo ""
echo "=================================================="
echo "  ✅ 同步完成！"
echo "  仓库地址：${GITHUB_REPO_URL%.git}"
echo "=================================================="
