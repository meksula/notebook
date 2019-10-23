#!/bin/bash

# positional parameters

VAR=$0     # wczytana do zmiennej zostanie komenda jaką wykonaliśmy
VAR_B=$1   # zmienna, która będzie wczytana jako pierwszy argument


# Bardzo ciekawa rzecz!
# Jeśli chcesz wykonywać w powłoce skrypty "automatycznie", jedynie poprzez wpisanie polecenia,
# np. git, ssh lub inne, wystarczy nadać prawa wykonywania dla skryptu oraz przenieść ten skrypt
# do katalogu /usr/bin/ albo /usr/local/bin.  Wtedy możesz wywołać skrypt tak jak się on nazywa.
# Katalog, w którym znajdują się pliki wykonawcze możemy sobie zdefiniować w zmiennej środowiskowej $PATH
#
# Jak już będziemy mieli "osadzony" plik w katalogu, na który wskazuje $PATH, będziemy mogli sprawdzić, 
# gdzie nasz program się znajduje za pomocą komendy `which`
#
# `dirname` ekstraktuje katalog ze ścieżki do pliku
# `basename` ekstraktuje z całej ścieżki nazwę pliku

DIR=$(dirname /some/directory/file.txt)
BASE=$(basename /some/directory/file.txt)

echo "$DIR"
echo "$BASE"

# 
# Kolejny protip: jak wpiszesz wykrzyknik i pierwszą literę, to odpali się ostatnio używana komenda,
# zaczynająca się na tą literę np. $ !v  - otworzy vima, jeśli wcześniej go otwierałeś.
#
#
# Jak sprawdzić ile argumentów zostało przyjętych w skrypcie?
PARAMS_NUMBER=${#}
echo "Args: $PARAMS_NUMBER"


#
#
# Pętla for
#
# Dla przykładu wygenerujmy hasła dla każdego z użytkowników
# 
for USERNAME in "${@}"  # bierzemy każdy argument jaki przyjdzie, jak damy `*` zamiast `@`, to wszystkie argumenty zostaną potraktowane jako jedno 
do
    PSWD=$(date +%s%N | sha512sum | head -c15)
    echo "${USERNAME}: $PSWD"
done


