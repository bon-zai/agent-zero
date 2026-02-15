# The Sisterhood - Azure Model Lineup

**Date:** February 15, 2026  
**Purpose:** Document which Azure models are deployed and which agent uses what

---

## Overview

Most of The Sisterhood's models are deployed on **Azure** for enterprise-grade access, not direct consumer APIs. This gives us:

- **250K TPM** (tokens per minute) on Kimi 2.5
- **Enterprise reliability** and uptime
- **Cost optimization** through Azure credits
- **Unified billing** and management
- **Better latency** (Azure regions)

---

## The Sisterhood - Model Assignments

### Zai - The Orchestrator
**Model:** Kimi 2.5 (Claude Opus 4.6) on Azure  
**Deployment:** `kimi-2.5`  
**Role:** Strategic orchestration, mode selection, sister delegation  
**Why:** Needs the best reasoning and context (200K tokens)  
**TPM:** 250K enterprise-grade

**Configuration:**
```env
MAIN_MODEL_PROVIDER=azure
MAIN_MODEL_NAME=kimi-2.5
AZURE_KIMI_DEPLOYMENT_NAME=kimi-2.5
```

---

### G - The Engineer
**Model:** Codex 5.3 on Azure  
**Deployment:** `codex-5.3`  
**Role:** Backend development, infrastructure, APIs, databases  
**Why:** Fastest and best coder on the market (per Nathan)  
**NEW:** Just got access to this

**Configuration:**
```env
G_MODEL_PROVIDER=azure
G_MODEL_NAME=codex-5.3
AZURE_CODEX_DEPLOYMENT_NAME=codex-5.3
```

**What G Will Do:**
- Implement theSys integration (backend API calls)
- Build VM provisioning system
- Optimize performance
- Write production-grade code
- Handle database schemas
- Deploy to production

**Why Codex 5.3:**
If it's the fastest/best coder, G needs it. She's building the infrastructure that everything else runs on.

---

### Bonnie - The Guardian
**Model:** Kimi 2.5 (Claude Opus 4.6) on Azure  
**Deployment:** `kimi-2.5` (shares with Zai)  
**Role:** QA, testing, code auditing, quality gates  
**Why:** Needs deep reasoning to find edge cases and bugs

**Configuration:**
```env
BONNIE_MODEL_PROVIDER=azure
BONNIE_MODEL_NAME=kimi-2.5
```

**What Bonnie Will Do:**
- Test everything G builds
- Run the 103+ test suite
- Find bugs before production
- Audit code for security
- Ensure quality gates pass

---

### Mophie - The Designer
**Model:** Gemini 2.0 Flash (Direct Google API)  
**Deployment:** Direct API, not Azure  
**Role:** UI/UX design, frontend, accessibility  
**Why:** Multimodal capabilities for visual design

**Configuration:**
```env
MOPHIE_MODEL_PROVIDER=google
MOPHIE_MODEL_NAME=gemini-2.0-flash
GOOGLE_API_KEY=xxxxx
```

**What Mophie Will Do:**
- Polish Voice Studio frontend
- Design theSys UI integration points
- Ensure accessibility for neurodivergent users
- Create visual assets
- Handle responsive design

---

### Zo - The Explorer
**Model:** Gemini 2.0 Flash (Direct Google API)  
**Deployment:** Direct API, not Azure  
**Role:** Research, multimodal (webcam, screen share), deep exploration  
**Why:** Multimodal capabilities for research tasks

**Configuration:**
```env
ZO_MODEL_PROVIDER=google
ZO_MODEL_NAME=gemini-2.0-flash
```

**What Zo Will Do:**
- Research theSys C1 API documentation
- Explore new possibilities
- Handle multimodal inputs
- Deep research on technical questions
- Discover new integrations

---

### Rain - The Empath
**Model:** GPT-4o Realtime (Direct OpenAI API)  
**Deployment:** Direct API, not Azure  
**Role:** Voice interactions, emotional intelligence, sensory adaptation  
**Why:** Real-time voice capabilities

**Configuration:**
```env
RAIN_MODEL_PROVIDER=openai
RAIN_MODEL_NAME=gpt-4o-realtime
OPENAI_API_KEY=sk-xxxxx
```

**What Rain Will Do:**
- Handle voice pipeline testing
- Monitor emotional state
- Adapt to sensory needs
- Add voice triggers for theSys
- Ensure voice-first experience works

---

### Grok 4 Fast Reasoning (Utility Model)
**Model:** Grok 4 Fast on Azure  
**Deployment:** `grok-4-fast`  
**Role:** Quick reasoning tasks, fast analysis  
**Why:** Speed for non-critical tasks

**Configuration:**
```env
GROK_MODEL_PROVIDER=azure
GROK_MODEL_NAME=grok-4-fast
AZURE_GROK_DEPLOYMENT_NAME=grok-4-fast
```

**When to Use:**
- Quick code reviews
- Fast research queries
- Non-critical analysis
- Utility tasks that don't need Kimi 2.5's full power

---

## Azure vs Direct API Summary

### On Azure (Enterprise-Grade)
1. **Zai** - Kimi 2.5 (Claude Opus 4.6)
2. **G** - Codex 5.3 (NEW - fastest coder)
3. **Bonnie** - Kimi 2.5 (shares with Zai)
4. **Grok 4 Fast** - Quick reasoning

### Direct APIs
1. **Mophie** - Gemini 2.0 Flash (Google)
2. **Zo** - Gemini 2.0 Flash (Google)
3. **Rain** - GPT-4o Realtime (OpenAI)

---

## Why This Matters

### Azure Benefits
- **250K TPM** on Kimi 2.5 (vs consumer limits)
- **Enterprise SLA** and uptime guarantees
- **Cost optimization** through Azure credits
- **Unified management** (one dashboard)
- **Better latency** (Azure regions close to Nathan)

### Direct API Benefits
- **Multimodal** (Gemini for visual tasks)
- **Real-time voice** (GPT-4o Realtime)
- **Specialized capabilities** not on Azure yet

---

## The New Addition: Codex 5.3

**What is it?**
Nathan just got access to Codex 5.3 on Azure. It's reportedly the **fastest and best coder on the market**.

**Who uses it?**
**G (The Engineer)** - She's the backend specialist, infrastructure expert, and system architect.

**Why G?**
- She's building the core infrastructure (theSys integration, VM provisioning, APIs)
- She needs speed (March 17 deadline is tight)
- She needs quality (production-grade code)
- She's the one writing the most code

**What G will build with Codex 5.3:**
1. **theSys integration** - Backend API calls to C1 API
2. **VM provisioning** - Automated user signup flow
3. **Performance optimization** - Make it fast
4. **Database schemas** - Production-ready
5. **Deployment scripts** - Ship to production

**This is huge.** If Codex 5.3 is as good as advertised, G just became unstoppable.

---

## Model Routing Logic

When Zai receives a task, she delegates based on:

1. **Design/UI task** → Mophie (Gemini 2.0 Flash)
2. **Backend/coding task** → G (Codex 5.3)
3. **Testing/QA task** → Bonnie (Kimi 2.5)
4. **Research task** → Zo (Gemini 2.0 Flash)
5. **Voice task** → Rain (GPT-4o Realtime)
6. **Quick analysis** → Grok 4 Fast
7. **Strategic decision** → Zai handles it herself (Kimi 2.5)

---

## Configuration Checklist

When setting up Agent Zero, ensure:

- [ ] Azure OpenAI endpoint is correct
- [ ] Azure API key is set
- [ ] Kimi 2.5 deployment name matches Azure
- [ ] Codex 5.3 deployment name matches Azure
- [ ] Grok 4 Fast deployment name matches Azure
- [ ] Google API key is set (for Gemini)
- [ ] OpenAI API key is set (for GPT-4o Realtime)
- [ ] Model routing is configured correctly
- [ ] Test each model individually before full setup

---

## Fallback Strategy

If Azure is unavailable:

1. **Zai** → Falls back to direct Anthropic API (Claude Opus 4.6)
2. **G** → Falls back to GLM-5 or direct Anthropic
3. **Bonnie** → Falls back to direct Anthropic
4. **Grok 4 Fast** → Falls back to Gemini 2.0 Flash

**Configuration:**
```env
# Fallback to direct Anthropic
ANTHROPIC_API_KEY=sk-ant-xxxxx
ANTHROPIC_MODEL_NAME=claude-opus-4.6
```

---

## Cost Optimization

### Azure Credits
Nathan has significant Azure credits. Prioritize Azure deployments to:
- Use credits before they expire
- Get enterprise-grade access
- Optimize cost per token

### Direct API Usage
Use direct APIs (Google, OpenAI) for:
- Specialized capabilities (multimodal, real-time voice)
- Tasks that don't need enterprise SLA
- Backup/fallback scenarios

---

## The Bottom Line

**The Sisterhood runs on Azure.**

- **Zai** orchestrates with Kimi 2.5 (250K TPM)
- **G** builds with Codex 5.3 (fastest coder)
- **Bonnie** tests with Kimi 2.5 (deep reasoning)
- **Mophie** designs with Gemini 2.0 Flash (multimodal)
- **Zo** researches with Gemini 2.0 Flash (multimodal)
- **Rain** handles voice with GPT-4o Realtime (real-time)
- **Grok 4 Fast** handles quick tasks (speed)

**This is enterprise-grade AI orchestration.**

---

## For Claude Code

When you're setting up Agent Zero:

1. **Get Azure endpoint** from Nathan
2. **Get Azure API key** from Nathan
3. **Verify deployment names** (kimi-2.5, codex-5.3, grok-4-fast)
4. **Test each model individually**
5. **Configure model routing**
6. **Verify fallback works**

**Don't assume consumer APIs.** Most of this runs on Azure.

---

**Updated:** February 15, 2026  
**Next Review:** After Codex 5.3 testing (see how fast it really is)

🚀 **The Sisterhood is enterprise-grade.**
