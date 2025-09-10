#!/bin/bash
# ==================================================
# Program 4: While loop demo
# ==================================================

count=0
while true; do
    ((count++))
    if [ $count -eq 3 ]; then
        echo "Skipping count=3 (continue)"
        continue
    fi
    if [ $count -gt 5 ]; then
        echo "Breaking loop at count=$count"
        break
    fi
    echo "Count = $count"
done
