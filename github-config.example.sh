#!/usr/bin/env bash
# =============================================================================
# github-config.example.sh — GitHub 配置模板（示例文件，可上传）
# 实际配置文件为 github-config.sh，由 Claude Code 自动生成，不会上传到 GitHub
# =============================================================================
#
# 使用方法：
#   复制此文件为 github-config.sh，填入你的信息，或直接通过 Claude Code 引导配置

# 状态值说明：
#   not_configured  — 尚未设置（首次使用时的初始值）
#   opted_out       — 用户选择不使用 GitHub，后续不再询问
#   configured      — 已配置完成，可正常推送

GITHUB_STATUS="not_configured"

GITHUB_REPO_URL=""        # 示例：https://github.com/username/slots-design.git
GITHUB_USERNAME=""        # 你的 GitHub 用户名
GITHUB_EMAIL=""           # 建议使用 GitHub noreply：username@users.noreply.github.com
GITHUB_BRANCH="main"
