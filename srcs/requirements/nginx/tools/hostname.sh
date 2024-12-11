#!/bin/bash

set +x

HOST_FILE="/etc/hosts"

LOCALHOST_LINE="127.0.0.1 localhost"
JHOST_LINE="127.0.0.1 whendrik.42.fr"

# If the JHOST_LINE already exists in /etc/hosts, exit the script
if grep -qE "^127\.0\.0\.1[[:space:]]+whendrik\.42\.fr" "$HOST_FILE"; then
    echo "$JHOST_LINE already exists in $HOST_FILE. Exiting."
    exit 0
fi

comment_line() {
        sed -i "s/^\($1\)/#\1/" "$HOST_FILE"
}

uncomment_line() {
        sed -i "s/^#\($1\)/\1/" "$HOST_FILE"
}

# Otherwise, proceed with the logic
if ! grep -q "^#\($JHOST_LINE\)\|^$JHOST_LINE" "$HOST_FILE"; then
        echo "$JHOST_LINE" >> "$HOST_FILE"
fi

if grep -q "^#\($LOCALHOST_LINE\)" "$HOST_FILE"; then
        uncomment_line "$LOCALHOST_LINE"
        if grep -q "^$JHOST_LINE" "$HOST_FILE"; then
                comment_line "$JHOST_LINE"
        fi
elif grep -q "^$LOCALHOST_LINE" "$HOST_FILE"; then
        comment_line "$LOCALHOST_LINE"
        if grep -q "^#\($JHOST_LINE\)" "$HOST_FILE"; then
                uncomment_line "$JHOST_LINE"
        fi
fi

cat "$HOST_FILE"

# This script is used to change the hosts file of the system.
# It adds the line for the whendrik.42.fr domain and comments the localhost line.
# If the localhost line is commented, it will uncomment it and comment the whendrik line.
# At the end, it will display the content of the hosts file.
