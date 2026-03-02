#!/bin/bash
#
#  File         : get_id_list-multi
#  Description  : Collect ID from 001 fields of all .mrc files in Input, prompt user for praefix and prepend it, 
#                 output one list of unique identifiers per file
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2026-02-06
#
#  History:
#  2026-02-06   : MJa      : creation
#  2026-02-09   : MJa      : add no-prefix option

clear

# Praefix Variable leeren und Benutzer zur Eingabe auffordern
echo "Welches Praefix haettens denn gern? (Eingabe 'n' wenn kein Praefix)"
while [ "$praefix" = "" ]
do
  read praefix
done

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "IDs aus 001 extrahieren und in Ausgabedatei schreiben..."
echo

for file in ./input/*.mrc
do
  filename="$(basename "$file" .mrc )"
  # Ausgabedatei leeren
> ./output/$filename.txt
  
  echo "Verarbeite $filename.mrc..."

  catmandu convert MARC to Text --field_sep "\n" --fix 'marc_map(001,id);retain(id)' < ./input/$filename.mrc >> ./output/$filename.txt 

  if [ "$praefix" != "n" ] ; then \
    echo "Praefix $praefix einfuegen..."
    sed -i "s/^/$praefix/" ./output/$filename.txt
  fi

  echo
done

# echo "ID-Liste deduplizieren..."
# sort -u ./output/ID-Liste.txt -o ./output/$praefix-ID-Liste_dedup.txt

# rm ./output/ID-Liste.txt

echo "###########################"
echo "Fertig! ID-Listen liegen in Output"
echo "###########################"
echo
