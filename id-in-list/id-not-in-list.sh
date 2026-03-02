#!/bin/bash
#
#  File         : id_not_in_list
#  Description  : Compare two lists of IDs, output a list of unique identifiers
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2024-01-19
#
#  History:
#  2024-01-19   : MJa      : creation

filecount="$(find input/*.txt -type f | wc -l)"

if [ "$filecount" -gt 2 ]; then
   echo
   echo "###########################"
   echo "Mehr als zwei .txt Datei vorhanden. Bitte nur zwei ID Listen in input legen."
   echo "###########################"
   echo
   exit 1;
fi

# Lieferung Variable leeren und Benutzer zur Eingabe auffordern
echo "IDs aus der neuen Lieferung: Bitte Dateiname eingeben"
while [ "$lieferung" = "" ]
do
  read lieferung
done

# Gesamtdatei Variable leeren und Benutzer zur Eingabe auffordern
echo "IDs aus dem E-Book Pool: Bitte Dateiname eingeben"
while [ "$gesamt" = "" ]
do
  read gesamt
done

# Ausgabedatei leeren
> ./output/id-not-in-list.txt

# grep -Fvxf <Lieferung> <Gesamtdatei>
grep -Fvxf ./input/$lieferung ./input/$gesamt > ./output/id-not-in-list.txt

echo
echo "###########################"
echo "id-not-in-list.txt liegt in Output"
echo "###########################"
echo
