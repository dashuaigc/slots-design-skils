# 执行流程详细规范

## Step 1 — 读取配置

1. 读取 `references/api-config.md`，检查 `API_STATUS` 值。
2. 若 `API_STATUS=not_configured`，进入 Step 2。
3. 若 `API_STATUS=configured`，跳到 Step 3。

---

## Step 2 — 首次配置引导

### Step 2.1 — 获取 API Key

先输出文字说明：
> 需要 apimart.ai 的 API Key 才能调用生图服务。
> 获取方式：访问 https://apimart.ai/console/token → 创建或复制 API Key。

```
Q1: "API Key 准备好了吗？请在 Other 中粘贴你的 API Key"
options:
  - 已准备好（在 Other 中粘贴）
  - 还没有，稍后配置
```

### Step 2.2 — 保存配置

1. 将用户提供的 API Key 写入 `references/api-config.md`，将 `API_STATUS` 改为 `configured`。
2. 输出确认消息："API Key 已保存，配置完成。"
3. 继续执行 Step 3。

---

## Step 3 — 收集生成参数

读取 `references/questionnaire.md`，按以下简化流程执行：

1. **Batch 1**：弹窗选择 Prompt 来源（从文件或手动输入）。
2. **Prompt 语言自动选择**：优先 `prompt_en`，无则用 `prompt_cn`，不弹窗。
3. **Batch 2**：弹窗选择画面比例、分辨率、生成数量（3 题一组）。
4. **自动默认值**：`google_search=true`、`google_image_search=true`、参考图=无（除非用户主动提供）。

---

## Step 4 — 直接提交

参数收集完成后**直接提交**，不再弹窗确认。

1. 读取 `references/api-spec.md` 获取端点和请求格式。
2. 使用 Python 构建 JSON payload（避免 shell 转义问题）：
   - 从 JSON 文件读取 Prompt 时，用 Python 读取文件并构建 payload
   - 写入 `../../outputs/nb2_payload.json` 临时文件（Step 6 完成后自动删除）
3. 使用 `curl` 调用生成 API：

```bash
curl -s -X POST "https://api.apimart.ai/v1/images/generations" \
  -H "Authorization: Bearer <API_KEY>" \
  -H "Content-Type: application/json" \
  -d @"$TEMP/nb2_payload.json"
```

若有参考图，在 payload 中加入 `"image_urls": [...]` 字段。

4. 解析响应，提取 `task_id`。若请求失败，按错误处理规则应对。

---

## Step 5 — 轮询任务状态

1. 每 5 秒查询一次：

```bash
curl -s -X GET "https://api.apimart.ai/v1/tasks/<TASK_ID>?language=zh" \
  -H "Authorization: Bearer <API_KEY>"
```

2. 响应结构为 `{"code":200,"data":{"status":"...","progress":...}}`，状态在 `data.status` 中。

3. 根据状态处理：
   - `pending`：显示 "排队中..."，继续轮询
   - `processing`：显示 "生成中... 进度 XX%"，继续轮询
   - `completed`：进入 Step 6
   - `failed`：显示错误信息，自动重试一次（等待 10 秒）
   - `cancelled`：显示已取消，结束

4. 轮询超时：最多 60 次（约 5 分钟），超时则提示用户。

---

## Step 6 — 结果处理

1. 从响应 `data.result.images` 数组中提取图片 URL。
2. 确保输出目录存在：`mkdir -p "../../outputs/images/"`
3. 使用 `curl -s -o` 直接下载每张图片，无需确认。
4. 文件命名规则：
   - 从已有 nb2 文件读取：`nb2_<主题>_<风格>_<YYYYMMDD>_<NNN>.png`
   - 手动输入：`nb2_manual_<YYYYMMDD>_<NNN>.png`
   - 多张图片追加字母后缀：`_001a.png`, `_001b.png`
5. 输出结果摘要（下载路径、耗时、分辨率）。
6. 使用 Read 工具展示生成的图片。
7. 自动删除临时 payload 文件（`../../outputs/nb2_payload.json`）。

---

## 错误处理

| 错误码 | 处理方式 |
|--------|---------|
| 401 | 提示 "API Key 无效或过期"，引导重新配置（将 `API_STATUS` 改回 `not_configured`） |
| 402 | 提示 "账户余额不足"，引导充值：https://apimart.ai/console |
| 429 | 提示 "请求频率超限"，等待 30 秒后自动重试 |
| 500/502 | 提示 "服务器错误"，等待 10 秒后自动重试（最多 3 次） |
