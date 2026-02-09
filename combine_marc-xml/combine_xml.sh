#!/bin/bash
#
#  File         : combine_xml
#  Description  : Combines all .xml files in "Input", output one ISO MARC file of all records
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2023-11-28
#
#  History:
#  2023-11-28   : MJa      : creation

filename="ZDB-98-IGI_Metadaten_MARCXML"

echo
echo "###########################"
echo "Verarbeitung $filename.txt gestartet um: $(date)"
echo "###########################"
echo

# Ausgabedatei leeren
> ./output/"$filename".mrc

echo "Leerzeichen in Dateinamen entfernen..."
while read line ; do mv "$line" "${line// /}" ; done < <(find ./input -iname "* *")

echo "Marc XML zu ISO umwandeln und in gemeinsame Ausgabedatei schreiben..."
for file in ./input/*.xml
do
echo "$file"
  catmandu convert MARC --type XML to MARC --type ISO < "$file" >> ./output/"$filename".mrc 
done

echo
echo "###########################"
echo "Verarbeitung beendet um: $(date)"
echo "$filename.mrc liegt in Output"
echo "###########################"
echo