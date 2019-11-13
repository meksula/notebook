#!/bin/bash

# Możmy u�c dwóch sposobów zapisu funkcji:

hello() {
   echo 'Hello function!'
}

# lub

function hello_2 {
   echo 'Hello function 2!'
}

hello


# Zmienne lokalne w zasiegu danej funkcji

local_example() {
   local ARGUMENTS="${@}"	# zmienna dostepna tylko w tym zasiegu
   echo "$ARGUMENTS"
}

local_example Hello World


# Jeszcze jeden przyklad `shift`

shift_test() {
  local ARGS=${@}
  shift		# Po prostu shift przesuwa wskaznik przyjetego indexu argumentu, do przodu
  echo "${1}"
  shift
  echo "${1}"   # Teraz indeks zostanie przesuniety i za kazdym razem drukowanie argument nr. 1 bedzie dawalo inny (kolejny rezultat)
}

shift_test 'A' 'B' 'C' 'D'


# readonly

readonly NAME='Karol'   # zmienna finalna, tylko do odczytu, nie mozna jej nadpisac

logger "Script end"
