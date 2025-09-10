#!/bin/bash
# ==================================================
# Program 5: Until loop demo
# ==================================================
# Until loops run UNTIL the condition becomes true

count=1
until [ $count -gt 5 ]; do
    if [ $count -eq 2 ]; then
        echo "Skipping count=2 (continue)"
        ((count++))
        continue
    fi
    echo "Count = $count"
    ((count++))
done
