# The Sisterhood - Agent Zero Workspace

## Project Identity

This is **bon-zai/agent-zero**, a fork of the Agent Zero autonomous AI framework, configured as **The Sisterhood's development workspace**. The goal: give 6 AI agents (The Sisterhood) full autonomy to finish building the **voice-avatar-stack** application.

**Owner:** Nathan Fyffe, Bonsai AI Technologies
**Mission:** Set up Agent Zero, configure The Sisterhood, give them access to voice-avatar-stack, then step back.

## The Sisterhood - Model Mapping (ACTUAL)

All models route through **Azure AI Foundry** (mofy-agents-resource) unless noted.

| Sister | Role | Provider | Model | Notes |
|--------|------|----------|-------|-------|
| **Zai** | Orchestrator (lead) | Azure/Anthropic | Claude Opus 4.6 | 1M ctx, 128K output, adaptive thinking |
| **Bonnie** | QA/Guardian | Azure/Anthropic | Claude Sonnet 4.5 | 1M ctx, 64K output |
| **G** | Backend Engineer | Google | Gemini 3 Flash Preview | Speed demon, 1M ctx |
| **Mophie** | Designer/UX | Google | Gemini 3 Pro Preview | Deep thinker, 65K output |
| **Zo** | Explorer/Research | Azure/xAI | Grok 4 Fast Reasoning | 2M ctx, real-time intel |
| **Rain** | Voice/Empath | TBD | TBD | Voice pipeline - needs config |
| **Utility** | Quick tasks | Azure/xAI | Grok 4 Fast Reasoning | Non-critical analysis |

### Azure Endpoints
- **Opus endpoint:** `https://mofy-agents-resource.openai.azure.com/anthropic`
- **Sonnet endpoint:** `https://mofy-agents-resource.services.ai.azure.com/anthropic`
- **Grok endpoint:** `https://mofy-agents-resource.openai.azure.com/openai/v1`

### Direct APIs
- **Gemini:** Google API direct (key: GOOGLE_API_KEY)
- **Anthropic fallback:** Direct API (key: ANTHROPIC_API_KEY)

## Infrastructure

| Instance | IP | Purpose |
|----------|----|---------|
| **mophie-clawdbot (118)** | 172.104.238.118 | PM2-managed, WhatsApp gateway |
| **voice-avatar-stack (121)** | 172.232.62.121 | 4x RTX 4000 Ada (80GB VRAM), Sisterhood backend |
| **Nathan's local** | localhost | 96GB RAM, 32GB VRAM, 9950X3D - dev workspace |

## Tech Stack

- **Runtime:** Python 3.12 (Flask + Uvicorn + Socket.IO)
- **LLM Layer:** LiteLLM (multi-provider routing via Azure + Google)
- **Embeddings:** HuggingFace sentence-transformers (local, no API needed)
- **Memory:** FAISS vector search (local) + Hindsight (Vectorize.io) + Supermemory
- **Web UI:** Flask static serving from `webui/` directory
- **MCP:** Client + server support for external tool integration
- **A2A:** FastA2A protocol for agent-to-agent communication
- **Browser:** browser-use integration via LangChain wrappers
- **Voice:** ElevenLabs TTS, Deepgram STT

## Key Entry Points

| File | Purpose |
|------|---------|
| `run_ui.py` | Main entry point - Flask/Uvicorn web server |
| `agent.py` | Core Agent class, AgentContext, AgentConfig |
| `models.py` | LiteLLM wrappers for chat, embedding, browser models |
| `initialize.py` | Agent initialization - model config from settings |
| `prepare.py` | Pre-flight checks |
| `preload.py` | Deferred model preloading |

## Project Structure

```
agent-zero/
  agent.py                    # Core agent logic
  models.py                   # LiteLLM model wrappers
  initialize.py               # Settings -> AgentConfig
  run_ui.py                   # Web UI entry point
  agents/                     # Agent profiles
    default/                  # Base profile (inherited)
    agent0/                   # Main user-facing agent
    developer/                # Dev-focused profile
    researcher/               # Research-focused profile
  prompts/                    # System prompt templates (.md + .py)
  python/
    api/                      # API endpoints (Flask routes)
    extensions/               # Hook system (agent_init, banners, etc.)
    helpers/                  # Utilities (settings, MCP, memory, etc.)
    tools/                    # Agent tools (code exec, browser, etc.)
  docker/run/                 # Docker configuration
    docker-compose.yml        # Container config (port 50080:80)
  webui/                      # Frontend static files
  knowledge/                  # Knowledge base files
  usr/                        # User data (settings, workdir, etc.)
    settings.json             # Persistent settings (auto-created)
  conf/
    model_providers.yaml      # Provider definitions for LiteLLM
```

## Configuration

### Environment (.env)
Settings override via `A0_SET_` prefix in `.env` file (gitignored).

**Required keys:**
- `ANTHROPIC_API_KEY` - Claude Opus 4.6 (Zai main model)
- `GOOGLE_API_KEY` - Gemini models (G, Mophie)

**Memory keys:**
- `HINDSIGHT_API_KEY` - Working memory (Vectorize.io, $10K credit)
- `SUPERMEMORY_API_KEY` - Universal KB ($5K credit)

**Optional:**
- `TAVILY_API_KEY` - Web search
- `ELEVENLABS_API_KEY` - Voice TTS

### Settings System
- Defaults in `python/helpers/settings.py` via `get_default_settings()`
- Override defaults with `A0_SET_{setting_name}` in `.env`
- Persistent changes saved to `usr/settings.json` (via UI or API)
- API keys resolved by `models.get_api_key()`: checks `API_KEY_{SERVICE}`, `{SERVICE}_API_KEY`, `{SERVICE}_API_TOKEN`
- Round-robin key support (comma-separated keys)

### Agent Profiles
- Located in `agents/{profile_name}/`
- Each has `agent.json` (metadata) + prompt overrides
- Extensions in `agents/{profile}/extensions/`
- Tools in `agents/{profile}/tools/`

## Running Agent Zero

```bash
# Run directly (preferred for dev)
python run_ui.py

# Run with Docker
cd docker/run && docker-compose up -d
```

Access UI at the port shown in console output (default: 50080).

## Important Context

- **Nathan has ADHD, autism, PTSD, bipolar** - design for neurodivergent users
- **voice-avatar-stack is 70% complete** - The Sisterhood finishes the remaining 30%
- **Voice-first** - WhatsApp, live voice, hands-free interaction
- **Persistent memory** - never forgets across sessions (Hindsight + Supermemory)
- **Glass Kitchen** - full transparency, users see what's happening
- **Self-healing** - dev Zai (in Agent Zero) fixes bugs reported by app Zai (in production)
- **No OpenAI** - all models route through Azure or Google direct
- **Enterprise-grade** - Azure AI Foundry with 250K TPM

## Key Documents

| Document | Purpose |
|----------|---------|
| `CLAUDE-CODE-INIT.md` | Mission brief for Claude Code |
| `THE-SISTERHOOD-MANIFESTO.md` | Full context, vision, philosophy |
| `SETUP.md` | Step-by-step technical setup guide |
| `AZURE-MODEL-LINEUP.md` | Model assignments and Azure config |
| `.env.sisterhood.template` | Environment variable template (outdated) |

## Conventions

- **Python style:** Follow existing Agent Zero patterns
- **Model access:** Always through LiteLLM wrappers in `models.py`
- **Settings:** Use `python/helpers/settings.py`, never hardcode
- **Extensions:** Hook system in `python/extensions/` with priority prefixes (`_10_`, `_15_`, etc.)
- **API routes:** Each in its own file under `python/api/`
- **No mutation:** Prefer immutable patterns
- **Providers:** Defined in `conf/model_providers.yaml`
