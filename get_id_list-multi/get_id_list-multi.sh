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
#  2026-04-02   : MJa      : append date to filename

clear

datum=$(date +"%Y-%m-%d")

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

  # Tagesdatum an Dateinamen haengen
  mv ./output/"${filename}.txt" ./output/"${filename}_${datum}.txt"

done

echo "###########################"
echo "Fertig! ID-Listen liegen in Output"
echo "###########################"
echo
