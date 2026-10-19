#!/usr/bin/env bash

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [[ $# -lt 1 ]]; then
    echo "Usage:"
    echo "  bash $0 IP1 IP2 ..."
    echo "  bash $0 -f <targets_file>"
    exit 1
fi

targets=()

# argument from file
if [[ "$1" == "-f" ]]; then
    if [[ $# -ne 2 || ! -f "$2" ]]; then
        echo "Error : please provide an existing file after -f"
        exit 1
    fi

    while IFS= read -r target || [[ -n "$target" ]]; do
        if [[ -z "$target" || "$target" == \#* ]]; then
            continue
        else
            targets+=("$target")
        fi
    done < "$2"

#argument fromt cli
else
    targets=("$@")
fi

if [[ "${#targets[@]}"  -eq 0 ]]; then
    echo "ERROR: no targets found"
    exit 1
fi

total=0
responding=0
no_responding=0

echo "======== Host Discovery ========"

for target in ${targets[@]}; do
    total=$((total + 1))

    if ping -c 3 -W 2 "$target" > /dev/null 2>&1; then
        echo -e "${GREEN} $target is responding${NC}"
        responding=$((responding + 1))
    else
        echo -e "${RED} $target is not responding${NC}"
        no_responding=$((no_responding + 1))
    fi
done

echo "======== SUMMARY ========"
echo "Total             : $total"
echo "Responding        : $responding"
echo "Not Responding    : $no_responding"
echo "========================="