#!/bin/bash
#
#  File         : get_thoth
#  Description  : Use an ID list to download Marc records from thoth API
#
#
#  Author(s)    : Melanie Janssen
#  Creation     : 2026-05-12
#
#  History:
#  2026-05-12   : MJa      : creation

. ~/.profile;
username=`whoami`
set -Eeuo pipefail

# Eingabedatei mit work_ids im Ordner input
filename="$(cd ./input && ls -1 *.txt)"
basename="$(basename "$filename" .txt )"

# Ausgabeverzeichnis fuer die heruntergeladenen Dateien
OUTPUT_DIR="output"

# Zaehler für heruntergeladene Datensaetze (muss mit 1 starten, sonst wird unten 0 % 0 geprueft)
count=1

echo
echo "###########################"
echo "Verarbeitung gestartet um: $(date)"
echo "Lade alle IDs aus $filename von API export.thoth.pub"
echo "###########################"
echo

# Output Ordner leeren
rm ./$OUTPUT_DIR/*.mrc

# Schleife ueber alle IDs
while IFS="" read -r id; do
  # Sicherstellen, dass ID nicht leer ist
  [[ -z "$id" ]] && continue

  # URL bilden aus der aktuellen work_id
  URL="https://export.thoth.pub/specifications/marc21record%3A%3Athoth/work/$id"

  # Dateiname
  FILENAME="$OUTPUT_DIR/thoth_${id}.mrc"

  echo "Lade $id herunter..."
  curl -s -X GET "$URL" -o "$FILENAME"

  # Pruefen, ob Download erfolgreich war
  if [[ $? -ne 0 ]]; then
    echo "Fehler beim Herunterladen von $id"
  fi

  # Fuer Pause: Zaehler erhoehen
  ((count++))
  
  # Nach jedem 500. Datensatz Pause von 1 Sekunde
  if (( count % 500 == 0 )); then
    echo "Pause von 1 Sekunde nach $count Datensaetzen..."
    sleep 1
  fi

done < input/"$filename"

  # Zaehler um 1 verringern, fuer korrekte Gesamtzahl
((count--))

echo "Download fertig: $count Datensaetze verarbeitet"

echo "Marc Dateien in gemeinsame Ausgabedatei schreiben..."
#cat $OUTPUT_DIR/*.mrc > $OUTPUT_DIR/$basename.all

echo "Marc Einzeldateien entfernen..."
#rm ./$OUTPUT_DIR/*.mrc

#mv $OUTPUT_DIR/$basename.all $OUTPUT_DIR/$basename.mrc

echo
echo "###########################"
echo "Verarbeitung beendet um: $(date)"
echo "$basename.mrc liegt in Output"
echo "###########################"
echo
