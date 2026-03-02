#!/bin/bash
#
#  File         : get_diff
#  Description  : Do a diff between the file in "input" and the previous download in "prev" and output a MARC file.
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2025-11-27
#
#  History:
#  2025-11-27   : MJa      : creation

. ~/.profile;
username=`whoami`
set -Eeuo pipefail

file="$(cd ./input && ls -1 *.mrc)"
filename="$(basename "$file" .mrc )"
prevname="$(cd ./prev && ls -1 *.mrc)"

# Ausgabedatei leeren
> ./output/${filename}_diff.mrc

clear

echo "Abgleich ${filename} und ${prevname}..."

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "IDs aus 001 extrahieren und in Ausgabedatei schreiben..."
for file in ./prev/*.mrc
do
  files="$(basename "$file" .mrc )"

  catmandu convert MARC to Text --field_sep "\n" --fix 'marc_map(001,id);retain(id)' < ./prev/${files}.mrc >> ./input/ID-Liste_${prevname}.txt
done

echo "ID-Liste deduplizieren..."
sort -u ./input/ID-Liste_${prevname}.txt -o ./input/ID-Liste_${prevname}_dedup.txt

rm ./input/ID-Liste_${prevname}.txt

echo "Liste fertiggestellt um: $(date +"%d.%m.%Y %H:%M")"
echo 
echo "Abgleich ID-Liste_${prevname}_dedup.txt und ${filename}_diff.mrc..."

echo "ID-Liste_${prevname}_dedup.txt fuer Catmandu vorbereiten..."
cp ./input/ID-Liste_${prevname}_dedup.txt ./input/input.copy
dos2unix ./input/input.copy   # Zeilenende: Windows CRLF durch Unix LF ersetzen
sed -i 's/$/,OK/' ./input/input.copy
sed -i '1s/^/key,value\n/' ./input/input.copy

for file in ./input/*.mrc
do
  catmandu convert MARC to MARC --fix filter.fix < "$file" >> ./output/${filename}_diff.mrc
done

rm ./input/input.copy

echo "Abgleich beendet um: $(date +"%d.%m.%Y %H:%M")"
echo 
echo "${filename}_diff.mrc liegt in Output"
echo "###########################"
echo
