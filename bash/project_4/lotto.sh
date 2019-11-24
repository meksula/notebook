#!/bin/bash

START=0
END=49
CURRENT=1

function random() {
  RES=$(echo "0123456789" | fold -w1 | shuf | head -c1)
  echo "$RES"
}

while [[ $CURRENT -le 6 ]];
do
   CURRENT=$((CURRENT+1))
   B=$(echo "01234" | fold -w1 | shuf | head -c1)
   if [[ $B -eq 0 ]]; then
     random
   else
     echo "${B}$(random)"
   fi   
done
