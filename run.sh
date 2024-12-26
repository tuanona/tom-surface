# run.sh
#!/bin/bash

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Simplified progress bar function
show_progress() {
    local title=$1
    echo -e "\n${BOLD}$title${NC}"
    for i in {1..3}; do
        echo -n "▇"
        sleep 0.2
    done
    echo -e " ${GREEN}Done!${NC}\n"
}

# Main script
echo -e "${BOLD}${BLUE}🚀 Starting Development Environment${NC}\n"

# Check dist folder
if [ -d "dist" ]; then
    echo -e "${GREEN}✓${NC} ${BOLD}dist folder exists${NC}"
else
    echo -e "${YELLOW}⚡${NC} ${BOLD}Building project...${NC}"
    
    if [ -f "yarn.lock" ]; then
        echo -e "Installing dependencies..."
        yarn install --frozen-lockfile
        if [ $? -ne 0 ]; then
            echo -e "${RED}✗ yarn install failed${NC}"
            exit 1
        fi
    else
        echo -e "${RED}✗ yarn.lock not found${NC}"
        exit 1
    fi
    
    echo -e "Building project..."
    yarn build
    if [ $? -ne 0 ]; then
        echo -e "${RED}✗ build failed${NC}"
        exit 1
    fi
fi

# Docker operations
show_progress "Stopping existing containers..."
docker-compose down

show_progress "Building Docker image..."
docker-compose build --no-cache

show_progress "Starting containers..."
docker-compose up -d

if [ $? -ne 0 ]; then
    echo -e "${RED}✗ docker-compose up failed${NC}"
    exit 1
fi

echo -e "${GREEN}✓${NC} ${BOLD}"
echo -e "Application is running on http://localhost:8050${NC}\n"
