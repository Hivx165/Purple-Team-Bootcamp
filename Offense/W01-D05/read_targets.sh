#!/usr/bin/env bash

while IFS= read -r target || [[ -n "$target" ]]; do
    echo "Target : $target"
done < targets.txt