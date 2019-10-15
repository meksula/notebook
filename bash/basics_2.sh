#!/bin/bash

# Jeśli UID = 0 to znaczy, że jesteś użytkownikiem root
# Jeśli jesteś zwykłym użytkownikiem to UID = 1000
echo "Your UID: $UID"

# Wyświetl jakim użytkownikiem jestem
MY_NAME=$(id -un)   # w nawiasie okrągłym możemy wywoływać komendę powłoki
MY_NAME=`id -un`    # efekt równoznaczny z powyższym

echo "I'm logged as: $MY_NAME"

if [[ "$UID" -eq 0 ]]     # jeśli UID == 0, nowa konwencja nakazuje używanie podwójnych kwadratowych nawiasów 
then
   echo "$MY_NAME you are root"
else
   echo "$MY_NAME you are not root"
fi

# Polecenia powłoki zwracają kody statusu
# 0 - true
# 1 - false
