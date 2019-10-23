#!/bin/bash

# Wydrukuj coś w konsoli
echo 'Hello'

# Przypisz wartość do zmiennej
VAR='script'

# Wyświetl zmienną
echo "$VAR"

# Jak będziemy chcieli wyświetlić zmienną w pojedyńczych cudzysłowach, nie wyświetli się!
echo '$VAR'

# Inne sposoby na interpolację zmiennych
echo "This is a bash $VAR"
echo "This is a bash ${VAR}"
echo "Bash ${VAR}ing is cool!"  # Tak możemy sobie oddzielić zmienną od reszty stringa, którego chcemy wyświetlić


# Reassignment zmiennej 
VAR='other value'
echo "Value changes: ${VAR}"
