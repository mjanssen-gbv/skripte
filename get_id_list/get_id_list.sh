#!/bin/bash
#
#  File         : get_id_list
#  Description  : Collect ID from 001 fields of all .mrc files in Input, prompt user for praefix and prepend it, 
#                 output one joint list of unique identifiers
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2023-03-27
#
#  History:
#  2023-03-27   : MJa      : creation
#  2026-03-02   : MJa      : add no-prefix option

# Praefix Variable leeren und Benutzer zur Eingabe auffordern
echo "Welches Praefix haettens denn gern?  (Eingabe 'n' wenn kein Praefix)"
while [ "$praefix" = "" ]
do
  read praefix
done

# Ausgabedatei leeren
rm ./output/*.txt

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "IDs aus 001 extrahieren und in Ausgabedatei schreiben..."
for file in ./input/*.mrc
do
  filename="$(basename "$file" .mrc )"
  
  echo "Verarbeite $filename.mrc..."

  catmandu convert MARC to Text --field_sep "\n" --fix 'marc_map(001,id);retain(id)' < ./input/$filename.mrc >> ./output/ID-Liste.txt 

  if [ "$praefix" != "n" ] ; then \
    echo "Praefix $praefix einfuegen..."
    sed -i "s/^/$praefix/" ./output/ID-Liste.txt
  fi

done

echo "ID-Liste deduplizieren..."
sort -u ./output/ID-Liste.txt -o ./output/${praefix}_ID-Liste_dedup.txt

rm ./output/ID-Liste.txt

echo "Fertig! ${praefix}_ID-Liste_dedup.txt liegt in Output"
