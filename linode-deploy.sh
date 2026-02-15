#!/bin/bash

# The Sisterhood - Linode Deployment Script
# This script deploys Agent Zero to a Linode server for 24/7 operation

set -e  # Exit on error

echo "=========================================="
echo "The Sisterhood - Linode Deployment"
echo "=========================================="
echo ""

# Check if SSH key exists
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "⚠️  No SSH key found. Generating one..."
    ssh-keygen -t rsa -b 4096 -C "nathan@bonzai-ai" -f ~/.ssh/id_rsa -N ""
    echo "✅ SSH key generated"
fi

# Get Linode IP
read -p "Enter your Linode IP address: " LINODE_IP

if [ -z "$LINODE_IP" ]; then
    echo "❌ Linode IP is required"
    exit 1
fi

# Get Linode user (default: root)
read -p "Enter Linode username (default: root): " LINODE_USER
LINODE_USER=${LINODE_USER:-root}

echo ""
echo "📦 Preparing deployment package..."

# Create deployment tarball
tar -czf agent-zero-deploy.tar.gz \
    .env \
    docker-compose.yml \
    Dockerfile* \
    requirements.txt \
    *.py \
    agents/ \
    conf/ \
    knowledge/ \
    lib/ \
    prompts/ \
    python/ \
    skills/ \
    webui/ \
    THE-SISTERHOOD-MANIFESTO.md \
    SETUP.md \
    CLAUDE-CODE-INIT.md \
    2>/dev/null || true

echo "✅ Deployment package created"

# Copy SSH key to Linode
echo ""
echo "🔑 Copying SSH key to Linode..."
ssh-copy-id -i ~/.ssh/id_rsa.pub ${LINODE_USER}@${LINODE_IP} || true

# Upload deployment package
echo ""
echo "📤 Uploading to Linode..."
scp agent-zero-deploy.tar.gz ${LINODE_USER}@${LINODE_IP}:/tmp/

# Deploy on Linode
echo ""
echo "🚀 Deploying on Linode..."

ssh ${LINODE_USER}@${LINODE_IP} << 'ENDSSH'
set -e

echo "Installing Docker..."
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com | sh
    systemctl enable docker
    systemctl start docker
fi

echo "Installing Docker Compose..."
if ! command -v docker-compose &> /dev/null; then
    curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

echo "Creating deployment directory..."
mkdir -p /opt/agent-zero
cd /opt/agent-zero

echo "Extracting deployment package..."
tar -xzf /tmp/agent-zero-deploy.tar.gz
rm /tmp/agent-zero-deploy.tar.gz

echo "Creating workspace directory..."
mkdir -p workspace/the-sisterhood

echo "Starting Agent Zero..."
docker-compose down || true
docker-compose up -d --build

echo "Waiting for Agent Zero to start..."
sleep 10

if docker ps | grep -q agent-zero; then
    echo "✅ Agent Zero is running on Linode!"
else
    echo "❌ Agent Zero failed to start"
    echo "Check logs with: docker-compose logs -f"
    exit 1
fi

ENDSSH

# Clean up local tarball
rm agent-zero-deploy.tar.gz

# Display success message
echo ""
echo "=========================================="
echo "✅ Deployment Complete!"
echo "=========================================="
echo ""
echo "Agent Zero is now running on Linode at: http://${LINODE_IP}:8080"
echo ""
echo "To access the Linode:"
echo "  ssh ${LINODE_USER}@${LINODE_IP}"
echo ""
echo "To view logs:"
echo "  ssh ${LINODE_USER}@${LINODE_IP} 'cd /opt/agent-zero && docker-compose logs -f'"
echo ""
echo "To restart:"
echo "  ssh ${LINODE_USER}@${LINODE_IP} 'cd /opt/agent-zero && docker-compose restart'"
echo ""
echo "To stop:"
echo "  ssh ${LINODE_USER}@${LINODE_IP} 'cd /opt/agent-zero && docker-compose down'"
echo ""
echo "Next steps:"
echo "1. Configure firewall to allow port 8080"
echo "2. Set up A2A connection to app Zai"
echo "3. Update APP_ZAI_ENDPOINT in .env on Linode"
echo ""
echo "🚀 The Sisterhood is now running 24/7!"
echo ""
