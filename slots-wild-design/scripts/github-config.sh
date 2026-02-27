#!/usr/bin/env bash
# =============================================================================
# github-config.sh — GitHub 连接状态配置文件
# 由 Claude Code 自动管理，无需手动编辑
# =============================================================================

# 状态值说明：
#   not_configured  — 尚未设置（首次使用时的初始值）
#   opted_out       — 用户选择不使用 GitHub，后续不再询问
#   configured      — 已配置完成，可正常推送

GITHUB_STATUS="configured"

# GitHub 仓库信息（配置成功后由 Claude 填写）
GITHUB_REPO_URL="https://github.com/dashuaigc/slots-design-skils.git"
GITHUB_USERNAME="dashuaigc"
GITHUB_EMAIL="dashuaigc@users.noreply.github.com"
GITHUB_BRANCH="main"      # 目标分支名
