#!/bin/bash

# GhostClaw 强力启动脚本
# 解决 2026.2.13 版本中自定义模型 Unknown 的问题

export OPENCLAW_GATEWAY_TOKEN="28e15709aa9799d3c91dcf5643f5a89481f071b216d48d50"

# 强制注入自定义代理 Provider 的环境变量 (OpenClaw 内核 Hook)
export OPENCLAW_CUSTOM_PROVIDERS='{"gemini-proxy": "https://ghost.zeabur.app/v1", "nvidia-proxy": "https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1"}'

echo "🦞 GhostClaw 正在通过系统 Hook 加载自定义代理..."
openclaw gateway --force
