#!/bin/bash

# Polecienie sort pozwala na posortowanie wynikow alfabetycznie
cat /etc/passwd | sort

# Alfabetyczne sortowanie z odwroconym pozadkiem
cat /etc/passwd | sort -r

# Zalozmy, ze mamy dane numeryczne (tutaj UID userow z pliku)
cat /etc/passwd | cut -d ':' -f 3 | sort      # w tym wypadku nadal sortowanie bedzie alfabetyczne!

# Flaga -n pozwala na sortowanie numeryczne
cat /etc/passwd | cut -d ':' -f 3 | sort -n

# Ponizsza komenda jest troche bardziej zlozona,
# 1. Listujemy otwarte porty netstatem
# 2. Szukamy tylko te ipki z dwukropkiem
# 3. Printujemy tylko czwarta kolumne
# 4. Dzielimy sobie linijke na ':' i wybieramy ostatni argument ($NF wybiera nam ostatni parametr)
# 5. Sortujemy numerycznie i unikalnie
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu

# Mozemy takze sortowac za pomoca polecenia `uniq`
# UWAGA! Jezeli uzywamy `uniq` dane musza byc posortowane!
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq

# Flaga -c nakazuje zeby uniq policzyl wystapienia danego wiersza w stdout
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c

# Ciekawym poleceniem jest `wc`, ktore zlicza rozne parametry z stdout
wc -l /etc/passwd    # zlicza wiersze w podanym pliku
wc -c /etc/passwd    # zlicza znaki w podanym pliku

# Ponizsze polecenie sortuje linie
# 1. Okreslony jest za pomoca `-t` delimiter
# 2. Nastepnie mamy okreslony numer kolumny za pomoca flagi `-k`
# 3. I na koncu mowimy, ze chcemy sortowac numerycznie
cat /etc/passwd | sort -t ':' -k 3 -n

# Takie polecenie na przyklad listuje wszystkie ipki, ktore probowaly sie logowac do naszego serwera
cat /var/log/auth.log | grep 'authentication' | cut -d '=' -f 7 | awk '{print $1}'

# Z kolei w ten sposob mozemy policzyc proby logowania per IP 
cat /var/log/auth.log | grep 'authentication' | cut -d '=' -f 7 | awk '{print $1}' | sort | uniq -c | sort -k 1 -n
