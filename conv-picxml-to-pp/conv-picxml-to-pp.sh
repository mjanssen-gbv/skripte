#!/bin/bash
#
#  File         : conv-picxml-to-pp
#  Description  : Use Picadata to transform all PicaXML .xml files in input to concatted Pica Import .pica file in output
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2025-10-20
#
#  History:
#  2025-10-20   : MJa      : creation

# Ausgabedatei leeren
> ./output/output.pica

# Arbeitsordner
cd input

echo "Pia XML nach Pica Import umsetzen und in Ausgabedatei schreiben..."
for file in *.xml
do
  filename="$(basename "$file")"
  echo "Verarbeite $filename"

  picadata $filename -f xml -t import >> ../output/output.pica
done

echo "Fertig! Pica Import Datei liegt in Output"
