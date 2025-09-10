#!/bin/bash
# ==================================================
# Program 2: Case statement demo
# ==================================================

read -p "Enter a letter (a/b/c/q to quit): " letter

case $letter in
    a|A) 
        echo "You entered A" 
        ;;
    b|B) 
        echo "You entered B" 
        ;;
    c|C) 
        echo "You entered C" 
        ;;
    q|Q)
        echo "Quitting..."
        ;;
    *) 
        echo "Invalid input"
        ;;
esac
