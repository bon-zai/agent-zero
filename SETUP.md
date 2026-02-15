# The Sisterhood - Local Setup Guide

**Target:** Nathan's local machine (96GB RAM, 32GB VRAM, 9950X3D)  
**Timeline:** 1-2 hours  
**Goal:** Get Agent Zero running locally with The Sisterhood configured

---

## Prerequisites

### 1. Docker Desktop

**macOS:**
```bash
# Download from https://www.docker.com/products/docker-desktop/
# Or install via Homebrew:
brew install --cask docker
```

**Windows:**
```bash
# Download from https://www.docker.com/products/docker-desktop/
# Requires WSL2
```

**Linux:**
```bash
# Ubuntu/Debian
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
# Log out and back in for group changes to take effect
```

**Verify Docker:**
```bash
docker --version
docker ps
```

### 2. Git

```bash
# Should already be installed, but verify:
git --version
```

### 3. Python 3.10+ (optional, for local testing)

```bash
python3 --version
# or
python --version
```

---

## Step 1: Clone the Repository

```bash
# Navigate to your projects directory
cd ~/projects  # or wherever you keep code

# Clone the forked agent-zero repo
git clone https://github.com/bon-zai/agent-zero.git
cd agent-zero
```

---

## Step 2: Configure Environment

### Create .env file

```bash
# Copy the template
cp .env.sisterhood.template .env

# Edit with your preferred editor
nano .env
# or
code .env
# or
vim .env
```

### Fill in API Keys

You'll need:

1. **Anthropic API Key** (for Zai + Bonnie)
   - Get from: https://console.anthropic.com/
   - Model: Claude Opus 4.6

2. **Google Gemini API Key** (for Mophie + Zo)
   - Get from: https://aistudio.google.com/
   - Model: Gemini 2.0 Flash

3. **GLM API Key** (for G)
   - Get from: https://open.bigmodel.cn/
   - Model: GLM-5

4. **OpenAI API Key** (for Rain + embeddings)
   - Get from: https://platform.openai.com/
   - Models: GPT-4o Realtime, text-embedding-3-small

5. **Supermemory API Key**
   - You have $5,000 credit
   - Get from your Supermemory dashboard

6. **Hindsight API Key**
   - You have $10,000 credit
   - Get from your Hindsight dashboard

7. **Tavily API Key** (optional, for web search)
   - Get from: https://tavily.com/

8. **Firecrawl API Key** (optional, for web scraping)
   - Get from: https://firecrawl.dev/

### Minimal .env for Testing

If you want to start with just Zai (recommended):

```env
# Minimal config - just Zai
MAIN_MODEL_PROVIDER=anthropic
MAIN_MODEL_NAME=claude-opus-4.6
ANTHROPIC_API_KEY=sk-ant-your-key-here

UTILITY_MODEL_PROVIDER=anthropic
UTILITY_MODEL_NAME=claude-3-5-sonnet-20241022

EMBEDDING_MODEL_PROVIDER=openai
EMBEDDING_MODEL_NAME=text-embedding-3-small
OPENAI_API_KEY=sk-your-key-here

MEMORY_PROVIDER=faiss
MEMORY_PATH=/workspace/memory

PROJECT_NAME=the-sisterhood
WORKSPACE_PATH=/workspace/the-sisterhood

MCP_ENABLED=false  # Enable later
A2A_ENABLED=false  # Enable later

LOG_LEVEL=INFO
WEB_UI_PORT=8080
```

---

## Step 3: Start Agent Zero

### Using Docker Compose (Recommended)

```bash
# Make sure you're in the agent-zero directory
cd ~/projects/agent-zero

# Start Agent Zero
docker-compose up -d

# Check if it's running
docker ps

# View logs
docker-compose logs -f
```

### Using Python Directly (Alternative)

```bash
# Install dependencies
pip install -r requirements.txt

# Run the UI
python run_ui.py
```

---

## Step 4: Access the Web UI

Open your browser to:
```
http://localhost:8080
```

You should see the Agent Zero interface.

---

## Step 5: Test Basic Functionality

### Test 1: Can Zai Respond?

In the Agent Zero UI, type:
```
Hi Zai, I'm Nathan. Can you confirm you're running and tell me about yourself?
```

**Expected response:**
- Zai introduces herself
- Confirms she's Claude Opus 4.6
- Mentions The Sisterhood

### Test 2: Can Zai Access the File System?

```
Zai, can you create a file called TEST.md in the workspace with the text "The Sisterhood was here"?
```

**Expected response:**
- File is created at `/workspace/the-sisterhood/TEST.md`
- Zai confirms the action

### Test 3: Can Zai Execute Code?

```
Zai, can you run a Python script that prints "Hello from The Sisterhood"?
```

**Expected response:**
- Script executes
- Output is shown
- Zai confirms success

---

## Step 6: Clone voice-avatar-stack

### Option A: If voice-avatar-stack is on GitHub

In the Agent Zero UI:
```
Zai, can you clone the voice-avatar-stack repository from GitHub into the workspace?

The repo is: https://github.com/bon-zai/voice-avatar-stack
```

### Option B: If voice-avatar-stack is local

On your local machine (outside Agent Zero):
```bash
# Navigate to your voice-avatar-stack directory
cd /path/to/voice-avatar-stack

# Create a tarball
tar -czf voice-avatar-stack.tar.gz .

# Copy to Agent Zero workspace
# (You'll need to mount a volume or use docker cp)
docker cp voice-avatar-stack.tar.gz agent-zero-container:/workspace/the-sisterhood/

# Then in Agent Zero UI:
# "Zai, can you extract voice-avatar-stack.tar.gz in the workspace?"
```

### Option C: If voice-avatar-stack is on Linode

```bash
# SSH into Linode
ssh nathan@your-linode-ip

# Navigate to voice-avatar-stack
cd /path/to/voice-avatar-stack

# Create tarball
tar -czf voice-avatar-stack.tar.gz .

# Download to local
scp nathan@your-linode-ip:/path/to/voice-avatar-stack.tar.gz ~/Downloads/

# Then follow Option B
```

---

## Step 7: Verify voice-avatar-stack Access

In Agent Zero UI:
```
Zai, can you:
1. List the main directories in voice-avatar-stack
2. Show me the structure of the backend directory
3. Read the README.md file
```

**Expected response:**
- Zai lists directories (backend, frontend, sisterhood, tests, docs)
- Shows backend structure
- Reads and summarizes README

---

## Step 8: Configure The Sisterhood (Full Setup)

### Update .env with all API keys

```bash
# Stop Agent Zero
docker-compose down

# Edit .env
nano .env

# Add all API keys (Gemini, GLM, Supermemory, Hindsight, etc.)

# Restart Agent Zero
docker-compose up -d
```

### Test Sister Delegation

In Agent Zero UI:
```
Zai, I need Mophie to review the frontend UI in voice-avatar-stack and suggest improvements. Can you delegate this to her?
```

**Expected response:**
- Zai delegates to Mophie
- Mophie analyzes the frontend
- Mophie provides design suggestions
- Zai summarizes the response

---

## Step 9: Enable MCP Servers

### Update .env

```env
MCP_ENABLED=true
SUPERMEMORY_API_KEY=your-key
HINDSIGHT_API_KEY=your-key
TAVILY_API_KEY=your-key
FIRECRAWL_API_KEY=your-key
```

### Restart Agent Zero

```bash
docker-compose restart
```

### Test MCP

```
Zai, can you search Supermemory for information about The Sisterhood architecture?
```

**Expected response:**
- Zai queries Supermemory
- Returns relevant information
- Confirms MCP is working

---

## Step 10: Enable A2A (Later, when app Zai is running)

### Update .env

```env
A2A_ENABLED=true
APP_ZAI_ENDPOINT=http://your-linode-ip:5000/a2a
```

### Restart Agent Zero

```bash
docker-compose restart
```

### Test A2A

```
Zai, can you ping the app Zai and ask for the current status of the voice pipeline?
```

**Expected response:**
- Dev Zai sends A2A message to app Zai
- App Zai responds with status
- Dev Zai relays the response

---

## Troubleshooting

### Issue: Docker won't start

**Solution:**
```bash
# Check Docker is running
docker ps

# Restart Docker Desktop (macOS/Windows)
# or
sudo systemctl restart docker  # Linux
```

### Issue: Port 8080 already in use

**Solution:**
```bash
# Change port in .env
WEB_UI_PORT=8081

# Or kill the process using 8080
lsof -ti:8080 | xargs kill -9  # macOS/Linux
```

### Issue: API key errors

**Solution:**
- Verify keys are correct in .env
- Check for extra spaces or quotes
- Ensure keys have proper permissions
- Test keys manually with curl

### Issue: Can't access voice-avatar-stack files

**Solution:**
```bash
# Check Docker volume mounts
docker inspect agent-zero-container | grep Mounts

# Ensure /workspace is mounted
# Edit docker-compose.yml if needed
```

### Issue: Zai not responding

**Solution:**
```bash
# Check logs
docker-compose logs -f

# Look for errors
# Common issues:
# - API rate limits
# - Invalid API keys
# - Network connectivity
```

---

## Next Steps

Once everything is working locally:

1. **Read THE-SISTERHOOD-MANIFESTO.md** (if you haven't already)
2. **Point Claude Code to CLAUDE-CODE-INIT.md** (next file)
3. **Let The Sisterhood start building**

---

## Hardware Optimization (Your Beast Machine)

With 96GB RAM and 32GB VRAM, you can:

### Enable GPU Acceleration (Optional)

```bash
# Install NVIDIA Docker runtime (if you have NVIDIA GPU)
# https://github.com/NVIDIA/nvidia-docker

# Update docker-compose.yml to use GPU
# Add to services.agent-zero:
#   deploy:
#     resources:
#       reservations:
#         devices:
#           - driver: nvidia
#             count: 1
#             capabilities: [gpu]
```

### Increase Memory Limits

```env
# In .env
MAX_CONTEXT_TOKENS=200000  # Full Opus 4.6 context
MEMORY_CACHE_SIZE=10000    # Larger memory cache
```

### Run Multiple Agents

With your resources, you could run:
- Dev Zai (Agent Zero)
- App Zai (voice-avatar-stack)
- Desktop Commander
- All on the same machine

---

## Maintenance

### Update Agent Zero

```bash
cd ~/projects/agent-zero
git pull origin main
docker-compose down
docker-compose up -d --build
```

### Backup Configuration

```bash
# Backup .env and workspace
tar -czf sisterhood-backup-$(date +%Y%m%d).tar.gz .env workspace/
```

### View Logs

```bash
# Real-time logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100

# Specific service
docker-compose logs -f agent-zero
```

---

## Resources

- **Agent Zero Docs:** https://github.com/agent0ai/agent-zero
- **Docker Docs:** https://docs.docker.com/
- **Anthropic API:** https://docs.anthropic.com/
- **Google Gemini API:** https://ai.google.dev/
- **The Sisterhood Manifesto:** `THE-SISTERHOOD-MANIFESTO.md`
- **Claude Code Init:** `CLAUDE-CODE-INIT.md`

---

## Support

If you run into issues:
1. Check the logs: `docker-compose logs -f`
2. Read the troubleshooting section above
3. Ask Zai (she's smart)
4. Ask Manus or Claude Code

---

**You're ready to build. Let's go.**

🚀 **The Sisterhood awaits.**
