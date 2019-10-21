#!/bin/bash

# Jak kodować i odkodowywać w bashu?

read -p "Type some text to encode: " PLAIN_TEXT

ENCODED=$(base64 ${PLAIN_TEXT})

echo "Encoded: $ENCODED"

DECODED=$(base64 -d ${ENCODED})

echo "Decoded: ${DECODED}"
