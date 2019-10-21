#!/bin/bash

# Aby sprawdzić integralność danych możemy wyliczyć checksum
# Służą do tego specjalne funkcje np. SHA1 albo SHA256 etc.
#
# Sprawdźmy czy oba pliki są takie same

PATH_FILE_A=$1
PATH_FILE_B=$2

if [[ $(sha256sum "$PATH_FILE_A") -eq $(sha256sum "$PATH_FILE_B") ]]
then
    echo "Matches!"
else
    echo "Not matches!"
fi 
