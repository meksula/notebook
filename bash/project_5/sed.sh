#!/bin/bash

# sed to edytor strumieni (Stream EDitor). Ciekawe narzędzie, dzięki któremu możemy modyfikować nasz stream,
# który jest właściwie wszędzie gdzie przekazujemy informacje z jednego procesu do innego.

#$ sed 's/text to replace/new text/flags' file.txt
Podstawowa składnia programu wygląda jak powyżej, 
  * najpierw podajemy tekst, który ma być zastąpiony
  * następnie tekst, który ma zastąpić pierwszy
  * oraz ścieżkę pliku
  
Opcja 'i' ignoruje wielkość liter.

! Domyślnie sed nie zamienia wszystkich wartości w tekście!
  Sed domyślnie zamienia tylko pierwsze wystąpienie w danej linii.

Opcja 'g' sprawia, że zamienione zostaną wszystkie wystąpienia frazy w danym strumieniu

sed 's/extrernal/internal/gi' documentation.txt

Możemy sprawić, że tylko drugie, trzecie albo n zostanie zaminione,
wystarczy podać cyfrę w opcjach

sed 's/extrernal/internal/2' documentation.txt

Jeśli tekst zawiera slashe, to możemy je normalnie wyescapeować.
Służy do tego backslash:

sed 's/\/home\/karol\/dev/\/opt\/app\/dev/'

Można też do escapeowania znaków użyć hasha '#', albo ':', nie ma znaczenia czego użyjemy

sed 's#/home/karol#/dev/opt/app#'


Możemy usuwać linie z pliku. Wszystko co zawiera frazę, zostanie usunięte.

sed 's/Some worlds/d' some_file.txt

Pamiętaj, że wpisane argumenty do seda, są wyrażeniami regularnymi!
Więc możemy jak najbardziej zrobić tak: (w celu usunięcia komentarzy)

sed 's/^#/d' script.py

Możemy łączyć operacje, oddzielając delimiterem ';'

sed 's/^#/d' ; 's/^$/d' ; 's/.py/.java/' source_file.py

Można doprecyzować, w której linii podmienić tekst, np.
wystarczy dodać cyfrę na początku:

sed '2 s/text to replace/new text/' file.txt

Albo z zakresem linii od 2 do 10:

sed '2,10 s/text to replace/new text/' file.txt

