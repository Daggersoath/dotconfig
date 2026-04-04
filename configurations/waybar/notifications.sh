#!/bin/bash

#dunstctl history | head -n 1

COUNT=$(dunstctl count history)
WAITING=$(dunstctl count waiting)

if [ "$WAITING" -ne 0 ]; then
    echo "   $WAITING" # Icon for unread/waiting
elif [ "$COUNT" -eq 0 ]; then
    echo "" # Empty bell icon
else
    echo "" # Standard bell icon
fi
