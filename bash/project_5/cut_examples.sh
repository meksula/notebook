#!/bin/bash

#### cut ####
# cut jak sama nazwa mowi, sluzy do ekstrakcji jakiejsc czesci tekstu z wiekszej czesci
# 
# cut -c 1 /etc/passwd             - przekazuje do stdout pierwszy znak w kazdym z wierszy
# cut -c 1-5 /etc/passwd           - przekazuje do stdout przedzial znakow od 1 do 5
# cut -d ':'                       - podzieli wiersze na delimiter podany do opcji -d
# cut -f 1                         - wybierze czesc podzialu wiersza, ktora okreslimy w opcji f
# cut -d ',' /etc/passwd -f 1      - podzieli wiersze z delimiterem jako przecinek i wybierze pierwsze wystapienie

#### grep ####
# grep pozwala na szybkie wyszukiwanie tekstu w plikach
#
# ^ oznacza w grep poczatek linii
# $ oznacza w grep koniec linii
# Opcja -v w grep oznacza, ze szukamy linii, ktore nie zawieraja danej frazy
# 	np:  '^some words$' /etc/passwd
#
# Mozemy na przyklad za pomoca grepa ominac sobie linie ktore zaczynaja sie dana fraza
# netstat -nutl | grep -v '^Active'            - wyswietli stdout bez linijki ktora zaczyna sie na Active
# netstat -nutl | grep -Ev '^Proto|^Active'    - wyswietli stdout bez linijej zaczynajacych sie na Proto lub Active
#

#### awk ####
# awk to potezne narzedzie, ale podstawowa funkcja moze byc na przyklad wydzielanie calych kolumn z outputu
# awk '{print $4}'        - wyswietli po prostu czwarta kolumne tekstu z jakiegos outputu
# awk -F ':' '{print}'    - jako delimiter zostanie uzyty dwukropek  
