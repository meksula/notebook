#!/bin/bash

# Jak dziala wbudowana funkcja getopts?
# Przyjmuje 3 argumenty:
# 1) Pierwszy mowi, ktore opcje sa dopuszczalne
# 2) Drugi argument, w tym wypadku OPTION to jest zmienna, ktora przyjmuje kolejna opcje w iteracji
# 3) Trzeci argument to opcje jakie funkcja getopts przyjmuje
#
# Zeby wywolac opcje 'l', musimy podac argument LENGTH. bez tego skrypt sie wywali


LEN=48

while getopts vs:l OPTION;
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      echo 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}"
      ;;
    s)
      USE_SPECIAL_CHARS='true'
      ;;
    ?)
      echo 'Option not recognized.' >$2
      exit 1
      ;;
  esac
done


