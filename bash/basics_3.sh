#!/bin/bash

# Jak rozpoznawać statusy wykonania komend?

CURRENT_USER=`id -un`
UID_USER=$UID
UID_REQUIRED=1000

if [[ "$UID_USER" -ne "$UID_REQUIRED" ]]
then
   echo "Your UID is not matching required"
   exit 1 
fi

USERNAME=vagrant
CREATE_USER=`useradd ${USERNAME}`


CODE="${?}"	# Bardzo ważne!!! Takie wywołanie sprawdza status ostatnio wykonanej operacji!!!

if [[ "$CODE" -eq 9 ]]
then
   echo "${USERNAME} just exist!"
fi
if [[ "${CODE}" -ne 0 ]]
then
   echo "Operation ends with failure!"
   exit 1	# Zostanie zwrócony kod 1 czyli niepowodzenie
fi

exit 0          # Zostanie zwrócony kod 0 jeśli wszystko przejdzie pomyślnie
