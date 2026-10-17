#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# 1. Check input
if [[ $# -lt 1 ]]; then
    echo "Usage : bash $0 IP1 IP2 ..."
    exit 1
fi

# 2. Initialize counters
total=0
responding=0
no_responding=0

# 3. Display header
echo "================================"
echo "       HOST DISCOVERY"
echo "================================"

# 4. Check each target
for target in "$@"; do
    total=$((total+1))

    if ping -c 1 -W 2 "$target" > /dev/null 2>&1; then
        echo -e "${GREEN}[+] $target is responding${NC}"
        responding=$((responding + 1))
    else
        echo -e "${RED}[-] $target did not respond${NC}"
        no_responding=$((no_responding + 1))
    fi
done

# 5. Display summary
echo
echo "================================"
echo "Total targets : $total"
echo "Responding    : $responding"
echo "No response   : $no_responding"
echo "================================"