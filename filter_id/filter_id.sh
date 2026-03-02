#!/bin/bash
#
#  File         : filter_id
#  Description  : Check whether ID from .txt file in "Input" is in 001 fields of any of the .mrc files in "Input", 
#                 output a MARC file of all records with these IDs
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2023-11-??
#
#  History:
#  2023-11-??   : MJa      : creation

filecount="$(find input/*.txt -type f | wc -l)"

if [ "$filecount" -gt 1 ]; then
   echo
   echo "###########################"
   echo "Mehr als eine .txt Datei vorhanden. Bitte nur eine ID Liste in input legen."
   echo "###########################"
   echo
   exit 1;
fi

workfile="$(find input/*.txt -type f)"
filename="$(basename "$workfile" .txt)"

echo
echo "###########################"
echo "Verarbeitung $filename.txt gestartet um: $(date)"
echo "###########################"
echo

# Ausgabedatei leeren
> ./output/"$filename".mrc

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "$filename.txt fuer Catmandu vorbereiten..."
cp ./input/"$filename".txt ./input/input.copy
dos2unix ./input/input.copy   # Zeilenende: Windows CRLF durch Unix LF ersetzen
sed -i 's/$/,OK/' ./input/input.copy
sed -i '1s/^/key,value\n/' ./input/input.copy

echo "IDs aus $filename in MARC Datei suchen und in Ausgabedatei schreiben..."
for file in ./input/*.mrc
do
echo "$file"
  catmandu convert MARC to MARC --fix filter.fix < "$file" >> ./output/"$filename".mrc 
done

rm ./input/input.copy

echo
echo "###########################"
echo "Verarbeitung beendet um: $(date)"
echo "$filename.mrc liegt in Output"
echo "###########################"
echo