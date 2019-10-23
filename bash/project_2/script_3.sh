#!/bin/bash

# Petla while wykonująca się aż przeleci przez wszystkie argumenty
#
# sleep - bardzo przydatna funkcja. Zatrzymuje działanie programu na 'x' sekund
#

ARGS=${#}
COUNTER=0
while [[ $ARGS -gt 0 ]]; 
do
    echo "Iteracja no. ${COUNTER}"
    COUNTER=$((COUNTER+1))       # inkrementacja
    ARGS=$((ARGS-1))             # dekrementacja
    sleep 2
    if [[ COUNTER -eq ${#} ]] 
    then
        echo "Koniec."
    fi
done



#
# sleep - bardzo przydatna funkcja. Zatrzymuje działanie programu na 'x' sekund
