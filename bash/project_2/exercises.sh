#!/bin/bash

USERNAME="${1}"

shift		# shift is a bash built-in which kind of removes arguments from the beginning of the argument list	

COMMENT="${@}"	# all arguments except first will used for comment

if [[ "${UID}" -ne 0 ]]; then
   echo "You have to run script as sudo user"
   exit 1
fi 

if [[ "${#}" -lt 1 ]]; then  # if was passed less arguments that 1
   echo "You have to pass arguments..."
   exit 1
fi  

PASSWORD=$(date +%s%N | sha256sum | head -c 20)

useradd -c "${COMMENT}" -m ${USERNAME}

if [[ "${?}" -ne 0 ]]; then
   echo 'Something went wront. Account not created' 
fi

echo $PASSWORD | passwd --stdin $USERNAME

if [[ "${?}" -ne 0 ]]; then
   echo 'Password not changed'
   exit 1
fi 

passwd -e $USERNAME   # user must change password on first account usage

echo "$USERNAME account was created with success on ${HOSTNAME}. Notice your password: $PASSWORD"

