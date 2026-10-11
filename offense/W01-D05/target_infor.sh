#!usr/bin/env bash

if [[ $# -lt 1 ]]; then
    echo "Usage: bash $0 <IP>"
    exit 1
fi

target="$1"
echo "Target : $target"