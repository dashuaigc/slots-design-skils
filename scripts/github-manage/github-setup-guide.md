# GitHub 手动配置指南

你选择了不自动连接 GitHub。如果将来改变主意，按以下步骤手动配置即可。

---

## 准备工作

### 第一步：注册 GitHub 账号
访问 https://github.com，注册一个免费账号（已有账号跳过）。

### 第二步：创建仓库
1. 登录 GitHub，点击右上角 **"+"** → **"New repository"**
2. 填写仓库名称（例如：`slots-design-skills`）
3. 选择 **Private**（私有，仅自己可见）或 **Public**
4. **不要**勾选 "Initialize this repository with a README"
5. 点击 **"Create repository"**
6. 复制页面上显示的 HTTPS 地址（格式：`https://github.com/你的用户名/仓库名.git`）

### 第三步：创建 Personal Access Token（访问令牌）
1. 点击 GitHub 右上角头像 → **Settings**
2. 滚动到底部，点击 **Developer settings**
3. 点击 **Personal access tokens** → **Tokens (classic)**
4. 点击 **Generate new token** → **Generate new token (classic)**
5. 填写名称（例如：`slots-backup`），设置过期时间（建议 1 年）
6. 勾选权限：**Public repositories**（完整仓库权限）
7. 点击 **Generate token**，**立即复制并保存**令牌（只显示一次！）

---

## 配置步骤

### 修改 github-config.sh
用文本编辑器打开：
```
e:\SKILLS\Slots\.claude\skills\scripts\github-manage\github-config.sh
```

将文件内容改为：
```bash
GITHUB_STATUS="configured"
GITHUB_REPO_URL="https://github.com/你的用户名/仓库名.git"
GITHUB_USERNAME="你的GitHub用户名"
GITHUB_EMAIL="你的邮箱@example.com"
GITHUB_BRANCH="main"
```

### 首次推送
在 Git Bash 中运行：
```bash
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/push-to-github.sh" "首次备份"
```

Windows 会弹出凭据窗口：
- 用户名：输入你的 GitHub 用户名
- 密码：粘贴上面复制的 Personal Access Token（**不是** GitHub 登录密码）

### 让 Claude Code 自动提交
配置完成后，告诉 Claude Code：
> "我已经手动配置好了 GitHub，以后每次更新 Skills 后请询问我要不要提交"

Claude Code 会读取配置文件并自动识别已配置状态。

---

## 版本管理

### 查看版本历史

查看 Skills 仓库的提交历史（版本记录、时间、内容）：

```bash
# 查看最近 10 条提交（默认）
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/github-history.sh"

# 查看最近 20 条
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/github-history.sh" 20

# 查看某条提交的详细文件变更
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/github-history.sh" --detail abc1234
```

### 回退到历史版本

将 Skills 文件恢复到某个历史版本的状态（非破坏性，会创建新提交记录回退操作）：

```bash
# 先预览回退将产生的变更（不执行修改）
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/github-rollback.sh" abc1234 --dry-run

# 确认后执行回退
bash "e:/SKILLS/Slots/.claude/skills/scripts/github-manage/github-rollback.sh" abc1234
```

**安全说明：**
- 回退会创建一个新的提交，完整历史始终保留，可随时再次回退
- `github-config.sh` 中的凭据信息不会被回退覆盖
- 建议先使用 `--dry-run` 预览变更后再执行

---

## 常见问题

**Q：忘记复制 Token 怎么办？**
A：回到 GitHub Developer settings，删除旧 token，重新生成一个。

**Q：推送时提示 "Authentication failed"？**
A：打开 Windows 控制面板 → 凭据管理器 → Windows 凭据，找到 `github.com` 相关条目删除，再次推送时重新输入。

**Q：想换一个仓库怎么办？**
A：修改 `github-config.sh` 中的 `GITHUB_REPO_URL`，然后在 Git Bash 中运行：
```bash
cd "e:/SKILLS/Slots"
git remote set-url origin 新仓库地址
```
