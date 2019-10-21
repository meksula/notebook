#!/bin/bash

# Example: generate some random passwords
LENGTH=$1
PASSWORD=""

while [[ ${#PASSWORD} -lt $LENGTH ]]; do
    PASSWORD=${PASSWORD}$RANDOM
done

echo "$PASSWORD"

# Other example:
#
# print daty w odpowiednim formacje, pipe do checksumy tej daty i pipe do heada z pierwszych 10 znaków
PSWD_OTHER=$(date +%s | sha256sum | head -c"${LENGTH}")
echo "$PSWD_OTHER"


# 
# Jak wybrać jedną, losową linijkę tekstu danego pliku?
#
# cat przekazuje stdin do folda, który dzieli tekst po spacjach, 
# następnie mieszamy podzielony tekst, a potem wybieramy losową, jedną linijkę
cat /etc/passwd | fold -s | shuf | head -n1
