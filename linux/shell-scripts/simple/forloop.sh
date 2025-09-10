#!/bin/bash
# ==================================================
# Program 3: For loop demo
# ==================================================

echo "For loop from 1 to 10"
for (( i=1; i<=10; i++ )); do
    if [ $i -eq 5 ]; then
        echo "Skipping $i (continue)"
        continue
    fi
    if [ $i -eq 8 ]; then
        echo "Breaking at $i"
        break
    fi
    echo "Iteration $i"
done
