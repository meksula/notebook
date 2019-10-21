#!/bin/bash

# Jak wybrać jakiś jeden lososwy znak z całego ciągu znaków?

INPUT=$1
LENGTH=1

# fold przyjmuje jako stdin zmienną i ją "rozbija na znaki"
# następnie shuf miesza losowo rezultat komendy fold
# a na końcu wyświetlamy tylko tyle znaków ile chcemy

echo "$INPUT" | fold -w1 | shuf | head -c${LENGTH} 


