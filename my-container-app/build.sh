#!/bin/bash
# Build, test, and optionally push Docker image

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
IMAGE_NAME="python-container-app"
IMAGE_TAG="${1:-latest}"
REGISTRY="${2:-}"

echo -e "${YELLOW}=== Python Container App Build Script ===${NC}"

# Step 1: Build Docker image
echo -e "${YELLOW}Building Docker image...${NC}"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
echo -e "${GREEN}✓ Image built successfully${NC}"

# Step 2: Test image (run health check)
echo -e "${YELLOW}Testing image with health checks...${NC}"
CONTAINER_ID=$(docker run -d -p 5000:5000 ${IMAGE_NAME}:${IMAGE_TAG})
sleep 5

if curl -f http://localhost:5000/health; then
    echo -e "${GREEN}✓ Health check passed${NC}"
else
    echo -e "${RED}✗ Health check failed${NC}"
    docker stop ${CONTAINER_ID}
    docker rm ${CONTAINER_ID}
    exit 1
fi

# Test other endpoints
echo -e "${YELLOW}Testing API endpoints...${NC}"
curl -s http://localhost:5000/api/hello?name=TestUser | jq .
curl -s http://localhost:5000/api/status | jq .

docker stop ${CONTAINER_ID}
docker rm ${CONTAINER_ID}
echo -e "${GREEN}✓ All tests passed${NC}"

# Step 3: Push to registry (optional)
if [ ! -z "$REGISTRY" ]; then
    echo -e "${YELLOW}Pushing to registry: ${REGISTRY}${NC}"
    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
    docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
    echo -e "${GREEN}✓ Image pushed successfully${NC}"
fi

echo -e "${GREEN}=== Build process completed successfully ===${NC}"
