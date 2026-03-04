# Nano Banana 2 API 规范

## 平台信息
- **服务商**：apimart.ai（代理 Google Gemini 3.1 Flash Image Preview）
- **文档**：https://docs.apimart.ai/cn/api-reference/images/gemini-3.1-flash/generation
- **Token 管理**：https://apimart.ai/console/token

---

## 1. 图像生成（提交任务）

### 端点
```
POST https://api.apimart.ai/v1/images/generations
```

### 认证
```
Authorization: Bearer <API_KEY>
Content-Type: application/json
```

### 请求参数

| 参数 | 类型 | 必填 | 默认值 | 说明 |
|------|------|------|--------|------|
| `model` | string | 是 | — | 固定值：`gemini-3.1-flash-image-preview` |
| `prompt` | string | 是 | — | 图像描述文本 |
| `size` | string | 否 | `1:1` | 画面比例 |
| `resolution` | string | 否 | `1K` | 输出分辨率 |
| `n` | integer | 否 | `1` | 生成数量 |
| `image_urls` | array | 否 | — | 参考图数组（最多14张） |
| `google_search` | boolean | 否 | `false` | 联网文字搜索增强 |
| `google_image_search` | boolean | 否 | `false` | 联网图片搜索增强 |

### size 可选值（画面比例）
| 值 | 说明 |
|----|------|
| `1:1` | 正方形 |
| `3:2` | 横版标准 |
| `2:3` | 竖版标准 |
| `4:3` | 横版经典 |
| `3:4` | 竖版经典 |
| `16:9` | 横版宽屏 |
| `9:16` | 竖版宽屏 |
| `5:4` | 横版微宽 |
| `4:5` | 竖版微宽 |
| `21:9` | 超宽屏 |
| `1:4` | 极竖 |
| `4:1` | 极横 |
| `1:8` | 超极竖 |
| `8:1` | 超极横 |

### resolution 可选值（输出分辨率）
| 值 | 说明 |
|----|------|
| `0.5K` | 低分辨率（快速预览） |
| `1K` | 标准分辨率（默认） |
| `2K` | 高分辨率 |
| `4K` | 超高分辨率 |

### image_urls 说明
- 最多 14 张参考图
- 支持格式：HTTP/HTTPS URL 或 Base64 Data URI
- 用途：图生图、风格参考、角色一致性

### 请求示例
```json
{
  "model": "gemini-3.1-flash-image-preview",
  "prompt": "A golden WILD slot icon with a dragon...",
  "size": "16:9",
  "resolution": "2K",
  "n": 1,
  "google_search": false
}
```

### 成功响应（200）
```json
{
  "code": 200,
  "data": [
    {
      "status": "submitted",
      "task_id": "task_01K8SGYNNNVBQTXNR4MM964S7K"
    }
  ]
}
```

---

## 2. 任务状态查询

### 端点
```
GET https://api.apimart.ai/v1/tasks/{task_id}
```

### 认证
```
Authorization: Bearer <API_KEY>
```

### 查询参数

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `language` | string | 否 | 响应语言：`zh`、`en`、`ko`、`ja` |

### 任务状态值
| 状态 | 说明 |
|------|------|
| `pending` | 排队等待 |
| `processing` | 生成中 |
| `completed` | 已完成 |
| `failed` | 失败 |
| `cancelled` | 已取消 |

### 成功响应字段
| 字段 | 类型 | 说明 |
|------|------|------|
| `id` | string | 任务 ID |
| `status` | string | 当前状态 |
| `progress` | integer | 进度百分比（0-100） |
| `created` | integer | 创建时间（Unix 时间戳） |
| `completed` | integer | 完成时间（Unix 时间戳） |
| `estimated_time` | integer | 预计耗时（秒） |
| `actual_time` | integer | 实际耗时（秒） |
| `result.images` | array | 图片结果数组（completed 时） |
| `error` | object | 错误信息（failed 时） |

### 错误对象结构
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "错误描述",
    "type": "错误类型"
  }
}
```

---

## 3. 错误码

| HTTP 状态码 | 说明 |
|-------------|------|
| 200 | 成功 |
| 400 | 请求参数无效 |
| 401 | 认证失败（API Key 无效或过期） |
| 402 | 余额不足 |
| 403 | 权限不足 |
| 429 | 请求频率超限 |
| 500 | 服务器内部错误 |
| 502 | 网关错误 |

---

## 4. curl 调用示例

### 提交生成任务
```bash
curl -X POST "https://api.apimart.ai/v1/images/generations" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gemini-3.1-flash-image-preview",
    "prompt": "A golden WILD slot icon...",
    "size": "16:9",
    "resolution": "1K",
    "n": 1
  }'
```

### 查询任务状态
```bash
curl -X GET "https://api.apimart.ai/v1/tasks/TASK_ID?language=zh" \
  -H "Authorization: Bearer YOUR_API_KEY"
```
