#!/bin/bash

# Ten skrypt pokazuje jak usunac uzytkownika 

if [[ ${UID} -ne 0 ]]; then
  echo 'Superuser privilages are required!' >&2
  exit 1
fi

if [[ "${#}" -eq 0 ]]; then
  echo "Arguments was not detected!" >&2
  exit 1
fi


USERNAME="${1}"

userdel $USERNAME

if [[ "${?}" -ne 0 ]]; then
  echo "Account for user '${USERNAME}' not deleted" >&2
  if [[ "${?} -eq 6" ]]; then
    echo "User $USERNAME not exists."
    exit 6
  fi
  exit 1
else
  echo "Account deleted correctly"
  exit 0
fi
