#!/usr/bin/env bash

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

is_ipv4() {
    local ip="$1"
    local octet
    local octets

    if [[ ! "$ip" =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]]; then
        return 1
    fi

    IFS='.' read -r -a octets <<< "$ip"

    for octet in "${octets[@]}"; do
        if [[ 10#$octet > 255 ]]; then
            return 1
        fi
    done

    return 0
}

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
invalid=0

echo "======== Host Discovery ========"

for target in ${targets[@]}; do
    total=$((total + 1))

    if ! is_ipv4 "$target"; then
        printf '%b\n' "${YELLOW}[!] Invalid Ipv4 : $target${NC}"
        invalid=$((invalid + 1))
        continue
    fi

    if ping -c 3 -W 2 "$target" > /dev/null 2>&1; then
        printf '%b\n' "${GREEN}[+] $target is responding${NC}"
        responding=$((responding + 1))
    else
        printf '%b\n' "${RED}[-] $target is not responding${NC}"
        no_responding=$((no_responding + 1))
    fi
done

echo "======== SUMMARY ========"
echo "Total             : $total"
echo "Responding        : $responding"
echo "Not Responding    : $no_responding"
echo "Invalid IPv4      : $invalid"
echo "========================="