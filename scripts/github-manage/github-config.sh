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
