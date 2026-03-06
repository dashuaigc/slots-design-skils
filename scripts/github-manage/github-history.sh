#!/usr/bin/env bash
# =============================================================================
# github-history.sh — 查看 Skills 版本提交历史
# 用法：bash github-history.sh [条数，默认10] [--detail <hash>]
#
# 模式：
#   bash github-history.sh           → 显示最近 10 条提交摘要
#   bash github-history.sh 20        → 显示最近 20 条提交摘要
#   bash github-history.sh --detail abc1234  → 显示指定提交的详细变更
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONFIG_FILE="$SCRIPT_DIR/github-config.sh"

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

# ── 同步远端信息 ──────────────────────────────────────────────────────────────
git fetch origin "$GITHUB_BRANCH" 2>/dev/null || true

# ── 解析参数 ──────────────────────────────────────────────────────────────────
MODE="list"
COUNT=10
DETAIL_HASH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --detail)
      MODE="detail"
      DETAIL_HASH="${2:?请提供 commit hash}"
      shift 2
      ;;
    *)
      COUNT="$1"
      shift
      ;;
  esac
done

# ── 模式一：提交摘要列表 ─────────────────────────────────────────────────────
if [ "$MODE" = "list" ]; then
  TOTAL=$(git rev-list --count HEAD 2>/dev/null || echo "0")

  echo "=================================================="
  echo "  Skills 版本历史（最近 ${COUNT} 条 / 共 ${TOTAL} 条）"
  echo "  仓库：${GITHUB_REPO_URL%.git}"
  echo "  分支：${GITHUB_BRANCH}"
  echo "=================================================="
  echo ""
  echo "哈希    | 提交时间            | 提交说明"
  echo "--------|---------------------|------------------------------------------"

  git log \
    --date=format:'%Y-%m-%d %H:%M' \
    --format='%h | %ad | %s' \
    -n "$COUNT"

  echo ""
  echo "=================================================="
  echo "  提示：使用 --detail <哈希> 查看某条提交的详细文件变更"
  echo "=================================================="
fi

# ── 模式二：单条提交详细信息 ─────────────────────────────────────────────────
if [ "$MODE" = "detail" ]; then
  # 验证 commit hash 存在
  if ! git cat-file -t "$DETAIL_HASH" &>/dev/null; then
    echo "❌ 找不到提交：$DETAIL_HASH"
    exit 1
  fi

  echo "=================================================="
  echo "  提交详细信息"
  echo "=================================================="
  echo ""

  # 基本信息
  git log --format='哈希：    %H
短哈希：  %h
提交时间：%ai
提交说明：%s' -1 "$DETAIL_HASH"

  echo ""
  echo "── 变更文件 ──────────────────────────────────────"
  git diff-tree --no-commit-id --name-status -r "$DETAIL_HASH"

  echo ""
  echo "── 变更统计 ──────────────────────────────────────"
  git show --stat --format='' "$DETAIL_HASH"

  echo ""
  echo "=================================================="
fi
