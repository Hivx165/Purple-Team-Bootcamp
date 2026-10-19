#!/usr/bin/env bash

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Check that arguments were supplied
if [[ $# -lt 1 ]]; then
    echo "Usage:"
    echo "  bash $0 <IP1> [IP2 ...]"
    echo "  bash $0 -f <targets_file>"
    exit 1
fi

# Store targets in a Bash array
targets=()

# File mode: read targets from a file
if [[ "$1" == "-f" ]]; then
    if [[ $# -ne 2 || ! -f "$2" ]]; then
        echo "Error: provide an existing file after -f"
        exit 1
    fi

    while IFS= read -r target || [[ -n "$target" ]]; do
        # Skip empty lines and comment lines
        [[ -z "$target" || "$target" == \#* ]] && continue

        targets+=("$target")
    done < "$2"

# Argument mode: use the IPs passed on the command line
else
    targets=("$@")
fi

# Ensure that the target list is not empty
if [[ ${#targets[@]} -eq 0 ]]; then
    echo "Error: no targets found"
    exit 1
fi

total=0
responding=0
no_response=0

printf '%b\n' "${YELLOW}===== HOST DISCOVERY =====${NC}"

for target in "${targets[@]}"; do
    total=$((total + 1))

    if ping -c 1 -W 2 "$target" > /dev/null 2>&1; then
        printf '%b\n' "${GREEN}[+] $target is responding${NC}"
        responding=$((responding + 1))
    else
        printf '%b\n' "${RED}[-] $target did not respond${NC}"
        no_response=$((no_response + 1))
    fi
done

echo
printf '%b\n' "${YELLOW}===== SUMMARY =====${NC}"
echo "Total targets : $total"
echo "Responding    : $responding"
echo "No response   : $no_response"