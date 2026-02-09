#!/bin/bash
#
#  File         : add-912
#  Description  : Add Marc field 912 based on user input and output a new Marc file
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2026-01-30
#
#  History:
#  2026-01-30   : MJa      : creation

# Lizenzjahr Variable leeren und User zur Eingabe auffordern
echo "$year - Lizenzjahr fuer 912 b:"
while [ "$year" = "" ]
do
  read year
done

for file in ./input/*.mrc
do

filename="$(basename "$file" .mrc)"

echo "Verarbeite $filename..."

# Sigel Variable leeren und User zur Eingabe auffordern
echo "Erstes Sigel fuer 912:"
while [ "$sigel1" = "" ]
do
  read sigel1
done

echo "Zweites Sigel fuer 912 (Eingabe 'n' wenn kein weiteres Sigel):"
while [ "$sigel2" = "" ]
do
  read sigel2
done

# Ausgabedatei leeren
> ./output/"$filename"_sigel.mrc

echo
echo "###########################"
echo

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "Sigel in $filename eintragen..."

  catmandu convert MARC to MARC --fix "marc_add('912', a, '$sigel1', 'b', '$year')" < "$file" >> ./output/"$filename"_sigel.mrc
  # Zweites Sigel
  if [ "$sigel2" != "n" ] ; then \
    catmandu convert MARC to MARC --fix "marc_add('912', a, '$sigel2', 'b', '$year')" < ./output/"$filename"_sigel.mrc >> ./output/"$filename"_sigel2.mrc
    # Dateinamen aufraeumen
    rm ./output/"$filename"_sigel.mrc
    mv ./output/"$filename"_sigel2.mrc ./output/"$filename"_sigel.mrc
  fi
  
echo
echo "###########################"
echo

sigel1=""
sigel2=""

done

echo
echo "###########################"
echo "Verarbeitung beendet um: $(date)"
echo "###########################"
echo
