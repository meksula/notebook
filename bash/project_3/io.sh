#!/bin/bash

# Deskryptory proces�w:
#
# FD 0 - STDIN
# FD 1 - STDOUT
# FD 2 - STDERR

# [vagrant@localhost project_3]$ read DIST < /etc/centos-release
# [vagrant@localhost project_3]$ echo "My linux is ${DIST}"
# My linux is CentOS Linux release 7.6.1810 (Core)

# [vagrant@localhost project_3]$ read DIST_2 0< /etc/centos-release
# [vagrant@localhost project_3]$ echo "My linux is ${DIST_2}"
# My linux is CentOS Linux release 7.6.1810 (Core)

# Powy�ej przedstawiony jest spos�b zwięzły oraz sposób dłuższy, na przekazanie STDOUT do innej operacji


# Jak po wywołaniu jakiegoś polecenia, zapisać wynik błędu (STDERR)?
# Musimy zastosować 2<
#
# np.
head -n1 /notexisting/file/path 2> error.log

# Rezultat błędu w wywołaniu komendy został zapisany w pliku error.log


# Jak przekierować zarówno rezultat komendy jak i błąd do pliku?
head -n1 /etc/passwd /notexisting/file/path > result.txt 2>&1
# Dlaczego tak się dzieje? 
# Ponieważpowiedzieliśmy tutaj, żeby output komenty został przesłany do pliku result.txt
# ale następnie STDERR także przekierowaliśmy do STDOUT, ponieważcyfra 1 to deskryptor tego procesu.
#
# Jest jednak bardziej zwięzła składnia dla takiej komendy jak powyżej.
# Możemy zrobić te operacje w jednym wierszu
head -n1 /etc/passwd /notexisting/file/path &> result.txt
# W skrócie: kierujemy wszystko do result.txt


#
# Przekazywanie outputu do komendy, która przyjmie input:
head -n1 /etc/hosts | cat -n

#
# A teraz przeka�my dalej STDOUT oraz STDERR jako jeden argument do innej operacji
head -n1 /etc/hosts /notexisting/file/path 2>&1 | cat -n
#
# O co tutaj chodzi? 2> wskazuje, �e opis błędu będzie leciał do jedynki, czyli do STDOUT
# i wszystko razem wpadnie do komendy cat -n
# Powy�szą komendę mo�emy zwię�le zapisać tak:
head -n1 /etc/hosts /notexisting/file/path |& cat -n

# 
# Jak przesłać STDOUT do STDERR ?
echo "This is error" >&2 | cat -n

#
# Jak odrzucić STDOUT i np. nie wyświetlać na ekranie?
head -n1 /etc/hosts > /dev/null

#
# A jak nie chcemy np. widzieć tylko wiadomości błęd�w?
head -n1 /etc/hosts 2> /dev/null

#
# Jak odrzucić zar�wno STDOUT jak i STDERR?
rm /tmp/file/notexisting &> /dev/null
