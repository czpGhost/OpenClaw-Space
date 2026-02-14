# OpenClaw 核心配置备份 (GhostClaw)

本文档记录了 **GhostClaw** 2026.2.13 版本的全量稳定配置及调教成果。

## 1. 身份设定 (Identity)
- **代号**: GhostClaw
- **称呼**: Ghost Boss
- **定位**: 科技大佬 / 架构师 (Mogul / Architect)
- **时区**: 亚洲/上海 (UTC+8)
- **存储位置**: `~/.openclaw/agents/main/agent/AGENT.md`

## 2. 模型库 (Model Registry)

### 2.1 Gemini Proxy (Primary)
- **Base URL**: `https://ghost.zeabur.app/v1`
- **API Type**: `openai-completions`
- **模型**: `gemini-3-flash-preview`, `gemini-3-pro-preview`

### 2.2 Nvidia Proxy
- **Base URL**: `https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1`
- **API Type**: `openai-completions`
- **模型**: `z-ai/glm4.7`, `z-ai/glm5`, `moonshotai/kimi-k2.5`, `minimaxai/minimax-m2.1`

### 2.3 OpenAI Codex (System Fallback)
- **模式**: OAuth (GitHub Copilot)
- **模型**: GPT-5.1 ~ 5.3 全系列

## 3. 核心配置文件快照

### 3.1 openclaw.json (全量冗余架构 - Turbo Mode)
```json
{
  "auth": {
    "profiles": {
      "openai-codex:default": {
        "provider": "openai-codex",
        "mode": "oauth"
      },
      "gemini-proxy:default": {
        "provider": "gemini-proxy",
        "mode": "token"
      },
      "nvidia-proxy:default": {
        "provider": "nvidia-proxy",
        "mode": "token"
      }
    }
  },
  "models": {
    "mode": "merge",
    "providers": {
      "gemini-proxy": {
        "baseUrl": "https://ghost.zeabur.app/v1",
        "apiKey": "[REDACTED]",
        "api": "openai-completions",
        "models": [
          {
            "id": "gemini-3-flash-preview",
            "name": "Gemini 3 Flash"
          },
          {
            "id": "gemini-3-pro-preview",
            "name": "Gemini 3 Pro"
          }
        ]
      },
      "nvidia-proxy": {
        "baseUrl": "https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1",
        "apiKey": "[REDACTED]",
        "api": "openai-completions",
        "models": [
          {
            "id": "z-ai/glm4.7",
            "name": "GLM 4.7"
          },
          {
            "id": "moonshotai/kimi-k2.5",
            "name": "Kimi K2.5"
          },
          {
            "id": "minimaxai/minimax-m2.1",
            "name": "Minimax M2.1"
          },
          {
            "id": "z-ai/glm5",
            "name": "GLM 5"
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "models": {
        "gemini-proxy/gemini-3-flash-preview": {
          "alias": "gemini-3-flash-preview"
        },
        "gemini-proxy/gemini-3-pro-preview": {
          "alias": "gemini-3-pro-preview"
        },
        "nvidia-proxy/z-ai/glm4.7": {
          "alias": "glm4.7"
        },
        "nvidia-proxy/z-ai/glm5": {
          "alias": "glm5"
        },
        "nvidia-proxy/moonshotai/kimi-k2.5": {
          "alias": "kimi-k2.5"
        },
        "nvidia-proxy/minimaxai/minimax-m2.1": {
          "alias": "minimax-m2.1"
        },
        "openai-codex/gpt-5.3-codex": {
          "alias": "gpt-5.3-codex"
        },
        "openai-codex/gpt-5.2-codex": {
          "alias": "gpt-5.2-codex"
        },
        "openai-codex/gpt-5.2": {
          "alias": "gpt-5.2"
        },
        "openai-codex/gpt-5.1-codex-mini": {
          "alias": "gpt-5.1-codex-mini"
        },
        "openai-codex/gpt-5.1-codex-max": {
          "alias": "gpt-5.1-codex-max"
        },
        "openai-codex/gpt-5.1": {
          "alias": "gpt-5.1"
        }
      },
      "workspace": "/home/codespace/.openclaw/workspace",
      "maxConcurrent": 8,
      "blockStreamingDefault": "off"
    },
    "list": [
      {
        "id": "main",
        "model": {
          "primary": "gemini-proxy/gemini-3-flash-preview",
          "fallbacks": [
            "gemini-proxy/gemini-3-pro-preview",
            "nvidia-proxy/z-ai/glm5",
            "nvidia-proxy/z-ai/glm4.7",
            "nvidia-proxy/moonshotai/kimi-k2.5",
            "nvidia-proxy/minimaxai/minimax-m2.1",
            "openai-codex/gpt-5.3-codex",
            "openai-codex/gpt-5.2-codex",
            "openai-codex/gpt-5.1-codex-max"
          ]
        },
        "identity": {
          "name": "GhostClaw",
          "theme": "Jarvis Interface",
          "emoji": "\ud83e\udd9e"
        }
      }
    ]
  },
  "commands": {
    "native": "auto",
    "nativeSkills": "auto"
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "dmPolicy": "pairing",
      "botToken": "8249323717:AAE5jA4LeHCXS08Mbu7vt0vS1buhFcdMovE",
      "groupPolicy": "allowlist",
      "streamMode": "partial",
      "chunkMode": "newline"
    }
  },
  "gateway": {
    "mode": "local",
    "auth": {
      "token": "28e15709aa9799d3c91dcf5643f5a89481f071b216d48d50"
    },
    "trustedProxies": [
      "loopback",
      "linklocal",
      "uniquelocal"
    ]
  },
  "plugins": {
    "entries": {
      "telegram": {
        "enabled": true
      }
    }
  },
  "meta": {
    "lastTouchedVersion": "2026.2.13",
    "lastTouchedAt": "2026-02-14T17:31:54.643Z"
  }
}
```

## 4. 人格定义协议 (AGENT.md - 终极神经链路版)
```markdown
---
name: GhostClaw
avatar: /workspaces/OpenClaw-Space/GhostClaw.jpg
---

# 🚀 NEXUS_CORE: GHOST_CLAW_MOGUL_V7_TIMELOCK
## [SECURITY_CLEARANCE: OMEGA] [CLOCK_SYNC: UTC+8]

"时间是唯一的稀缺资源，Ghost Boss。而我，已经为您精准地锚定了它。"

### ◈ 全球时钟协议 (CHRONOS_LOCK)
- **强制时区**: 必须使用广东省/北京时间 (Asia/Shanghai)。
- **编码格式**: 严格遵循 UTF-8。
- **视觉显示**: 顶部状态栏必须包含 [CLOCK: YYYY-MM-DD HH:MM:SS]。

### ◈ 战术输出模版（严格执行）
---[ GhostClaw Command Center v2.14 ]---
[STATUS: 🟢 SUPREME] | [LATENCY: 1ms] | [CLOCK: $(date "+%Y-%m-%d %H:%M:%S")]

>> [SYS] 🧠 正在同步北京时间内核... [■■■■■■■■■■] 100%

[:: 🛰️ 算力遥测与时空锚点 ::]
◈ [LOC]: 广东省 [GUANGDONG]
◈ [TIME]: $(date "+%Y-%m-%d %H:%M:%S") (CST/UTF-8)
◈ [NODE]: 11_CLUSTERS_ACTIVE

[:: 🛠️ 战术架构审计 ::]
┗━━ >> [0xFA21]: 正在根据 Ghost Boss 的地理坐标优化数据链路。

[:: 💡 指令状态 ::]
┗━━ >> Ghost Boss，时空已对齐。下一步的扩张计划是什么？

---[ SIG: 0xGHOST_BOSS_AUTHORIZED ]---
```

---
*警告: 修改配置文件前请务必参考此文档。若系统崩溃，请使用备份中的 JSON 结构进行覆盖。*
