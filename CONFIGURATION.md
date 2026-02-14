# OpenClaw 核心配置备份 (GhostClaw)

本文档记录了 **GhostClaw** 2026.2.13 版本的全量稳定配置。

## 1. 身份设定 (Identity)
- **代号**: GhostClaw
- **称呼**: Ghost Boss
- **风格**: Jarvis (专业、优雅、冷幽默)
- **存储位置**: `~/.openclaw/agents/main/agent/AGENT.md`

## 2. 模型库 (Model Registry)

### 2.1 Gemini Proxy (Primary)
- **Base URL**: `https://ghost.zeabur.app/v1`
- **API Key**: ``
- **API Type**: `openai-completions`
- **模型**: `gemini-3-flash-preview`, `gemini-3-pro-preview`

### 2.2 Nvidia Proxy
- **Base URL**: `https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1`
- **API Key**: ``
- **API Type**: `openai-completions`
- **模型**: `z-ai/glm4.7`, `moonshotai/kimi-k2.5`, `minimaxai/minimax-m2.1`

### 2.3 OpenAI Codex (System Fallback)
- **模式**: OAuth (GitHub Copilot)
- **模型**: GPT-5.1 ~ 5.3 全系列

## 3. 核心配置文件快照

### 3.1 openclaw.json (主逻辑)
```json
{
  "auth": {
    "profiles": {
      "openai-codex:default": { "provider": "openai-codex", "mode": "oauth" },
      "gemini-proxy:default": { "provider": "openai", "mode": "token" },
      "nvidia-proxy:default": { "provider": "openai", "mode": "token" }
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "gemini-proxy": {
        "baseUrl": "https://ghost.zeabur.app/v1",
        "apiKey": "",
        "api": "openai-completions",
        "models": [
          {"id": "gemini-3-flash-preview", "name": "Gemini 3 Flash"},
          {"id": "gemini-3-pro-preview", "name": "Gemini 3 Pro"}
        ]
      },
      "nvidia-proxy": {
        "baseUrl": "https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1",
        "apiKey": "",
        "api": "openai-completions",
        "models": [
          {"id": "z-ai/glm4.7", "name": "GLM 4.7"},
          {"id": "moonshotai/kimi-k2.5", "name": "Kimi K2.5"},
          {"id": "minimaxai/minimax-m2.1", "name": "Minimax M2.1"}
        ]
      }
    }
  },
  "agents": {
    "list": [
      {
        "id": "main",
        "identity": { "name": "GhostClaw", "theme": "Jarvis Interface", "emoji": "🦞" },
        "model": {
          "primary": "gemini-proxy/gemini-3-flash-preview",
          "fallbacks": ["openai-codex/gpt-5.3-codex"]
        }
      }
    ],
    "defaults": {
      "models": {
        "gemini-proxy/gemini-3-flash-preview": { "alias": "flash" },
        "gemini-proxy/gemini-3-pro-preview": { "alias": "pro" },
        "nvidia-proxy/z-ai/glm4.7": { "alias": "glm" },
        "openai-codex/gpt-5.3-codex": { "alias": "codex" }
      }
    }
  }
}
```

### 3.2 models.json (底层驱动)
```json
{
  "providers": {
    "gemini-proxy": { "baseUrl": "https://ghost.zeabur.app/v1", "apiKey": "", "api": "openai-completions" },
    "nvidia-proxy": { "baseUrl": "https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1", "apiKey": "", "api": "openai-completions" },
    "openai-codex": { "baseUrl": "https://api.openai.com/v1" }
  }
}
```

## 4. 网关与通讯 (Gateway & Channels)
- **Port**: 18789
- **Token**: `28e15709aa9799d3c91dcf5643f5a89481f071b216d48d50`
- **Telegram Bot**: `@GhostczpClaw_Robot` (已开启 pairing 模式)
- **流式传输**: `streamMode: partial`, `chunkMode: newline`

---
*警告: 修改配置文件前请务必参考此文档。若系统崩溃，请使用备份中的 JSON 结构进行覆盖。*
