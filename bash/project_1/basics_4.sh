#!/bin/bash

# Pamiętaj, że jak będziemy w skrypcie oczekiwać stringa ze spacjami, 
# to musimy taką zmienną opakować w cudzysłów.

CURRENT_UID=$UID
CURRENT_USERNAME=`id -un`

if [ "$CURRENT_UID" -ne 0 ]
then
   echo "This script is available only for sudo users!"
   echo "${CURRENT_USERNAME}! Log in as root account maybe!"
   exit 1
fi

read -p 'Type username: ' USERNAME
read -p 'Type comment to new user: ' COMMENT
read -p 'Type password now: ' PASSWORD

# -c dodaje komentarz, a -m tworzy domyślny katalog domowy, jeśli taka opcja jest 
# domyślnie wyłączona w /etc/login.defs
useradd -c "${COMMENT}" -m ${USERNAME}
echo "${PASSWORD}" | passwd --stdin $USERNAME
