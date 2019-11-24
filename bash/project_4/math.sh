#!/bin/bash

# Bash standardowo nie zwraca czesci dziesietnych z dzialan arytmetycznych.
# 6 / 4 zwroci nam 1
# Aby umozliwic dzialania na liczbach dziesietnych mozemy doinstalowac pakiet 'bc'
# mozemy go potem uzyc:

echo '6 / 4' | bc
# >> 1.5

#Inkrementacja/dekrementacja:
NUM=$((NUM-1))

# lub:
(( NUM-- ))
(( NUM++ ))

# Takie dzialanie tez jest dozwolone
(( NUM += 5))

# Kolejnym sposobem na dzialania matematyczne jest uzycie expr:
expr 1 + 1


