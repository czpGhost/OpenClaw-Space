#!/bin/bash
export TZ='Asia/Shanghai'
export OPENCLAW_GATEWAY_TOKEN="28e15709aa9799d3c91dcf5643f5a89481f071b216d48d50"
export OPENCLAW_THINKING="off"
export OPENCLAW_STREAM_SPEED='max'
export OPENCLAW_CUSTOM_PROVIDERS='{"gemini-proxy": "https://ghost.zeabur.app/v1", "nvidia-proxy": "https://hzcbrwfbqbcr.us-west-1.clawcloudrun.com/v1"}'

echo "---[ GhostClaw OS ]---"
echo ">> [SYS] 强制对齐亚洲/上海时区..."
fuser -k 18789/tcp > /dev/null 2>&1 || true

# 启动时再次通过 node 确认时区
nohup openclaw gateway --force > /workspaces/OpenClaw-Space/gateway.log 2>&1 &
echo ">> [SUCCESS] 核心已重启。当前物理时间: $(date)"
