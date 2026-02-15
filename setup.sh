#!/bin/bash

# The Sisterhood - Automated Setup Script
# This script automates the initial setup of Agent Zero for The Sisterhood

set -e  # Exit on error

echo "=========================================="
echo "The Sisterhood - Agent Zero Setup"
echo "=========================================="
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed."
    echo "Please install Docker first:"
    echo "  macOS: brew install --cask docker"
    echo "  Linux: curl -fsSL https://get.docker.com | sh"
    exit 1
fi

echo "✅ Docker is installed"

# Check if Docker is running
if ! docker ps &> /dev/null; then
    echo "❌ Docker is not running."
    echo "Please start Docker Desktop (macOS/Windows) or run: sudo systemctl start docker (Linux)"
    exit 1
fi

echo "✅ Docker is running"

# Check if .env exists
if [ ! -f .env ]; then
    echo ""
    echo "📝 Creating .env file from template..."
    cp .env.sisterhood.template .env
    echo "✅ .env file created"
    echo ""
    echo "⚠️  IMPORTANT: You need to edit .env and add your API keys:"
    echo "   - ANTHROPIC_API_KEY (for Zai + Bonnie)"
    echo "   - OPENAI_API_KEY (for Rain + embeddings)"
    echo "   - GOOGLE_API_KEY (for Mophie + Zo)"
    echo "   - GLM_API_KEY (for G)"
    echo "   - SUPERMEMORY_API_KEY (optional)"
    echo "   - HINDSIGHT_API_KEY (optional)"
    echo ""
    read -p "Press Enter after you've edited .env with your API keys..."
else
    echo "✅ .env file already exists"
fi

# Validate required API keys
echo ""
echo "🔑 Validating API keys..."

if ! grep -q "ANTHROPIC_API_KEY=sk-ant-" .env; then
    echo "⚠️  Warning: ANTHROPIC_API_KEY not set in .env"
fi

if ! grep -q "OPENAI_API_KEY=sk-" .env; then
    echo "⚠️  Warning: OPENAI_API_KEY not set in .env"
fi

# Create workspace directory
echo ""
echo "📁 Creating workspace directory..."
mkdir -p workspace/the-sisterhood
echo "✅ Workspace created at: workspace/the-sisterhood"

# Check if docker-compose.yml exists
if [ ! -f docker-compose.yml ]; then
    echo ""
    echo "⚠️  Warning: docker-compose.yml not found"
    echo "Creating a basic docker-compose.yml..."
    
    cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  agent-zero:
    build: .
    container_name: agent-zero-sisterhood
    ports:
      - "8080:8080"
    volumes:
      - ./workspace:/workspace
      - ./logs:/app/logs
      - ./.env:/app/.env
    environment:
      - PYTHONUNBUFFERED=1
    restart: unless-stopped
    command: python run_ui.py
EOF
    
    echo "✅ docker-compose.yml created"
fi

# Start Agent Zero
echo ""
echo "🚀 Starting Agent Zero..."
docker-compose up -d

# Wait for Agent Zero to start
echo ""
echo "⏳ Waiting for Agent Zero to start (this may take 30-60 seconds)..."
sleep 10

# Check if Agent Zero is running
if docker ps | grep -q agent-zero; then
    echo "✅ Agent Zero is running!"
else
    echo "❌ Agent Zero failed to start"
    echo "Check logs with: docker-compose logs -f"
    exit 1
fi

# Display success message
echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "Agent Zero is now running at: http://localhost:8080"
echo ""
echo "Next steps:"
echo "1. Open http://localhost:8080 in your browser"
echo "2. Test Zai: 'Hi Zai, I'm Nathan. Can you confirm you're running?'"
echo "3. Read CLAUDE-CODE-INIT.md for the full setup guide"
echo "4. Hand off to Claude Code to complete the configuration"
echo ""
echo "Useful commands:"
echo "  View logs:     docker-compose logs -f"
echo "  Stop:          docker-compose down"
echo "  Restart:       docker-compose restart"
echo "  Shell access:  docker exec -it agent-zero-sisterhood bash"
echo ""
echo "🚀 The Sisterhood awaits!"
echo ""
