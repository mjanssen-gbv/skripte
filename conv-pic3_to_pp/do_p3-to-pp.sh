#!/bin/bash

#
#  File         : do_p3-to-pp.sh
#  Description  : Convert Pica3 to PICA+ 
#
#  Author(s)    : Melanie Janssen
#  Creation     : 18-10-2023
#
#  History:
#  18-10-2023   : MJa      : creation

function PrintUsage {
    echo
    echo "*** Usage: $1 <filename>"
    echo
    echo "Dieses Skript konvertiert Pica3 Dateien nach PICA+" 
    echo
    echo "Options:"
    echo "    <filename>      Dateiname der Pica3 Datei"
    echo "                    Das muss der erste Parameter sein!"
    echo "                    Pica3 Datei muss im input Ordner liegen!"
    echo "    -h              Diese Hilfeseite anzeigen"
    echo
}

clear

if [[ $# -eq 0 || "$1" = "-h" ]]
then
  PrintUsage $0
  exit 1
fi

# --- Variablen ---
file=$1
file_name=${file%.*}

echo
echo "##############################################################"
echo " Pica Konvertierung gestartet: $(date)" 
echo "##############################################################"
echo
# --- Datei aus input in workdir kopieren ---
cp ./input/* ./workdir

# --- In workdir Ordner wechseln ---
cd workdir

echo "-------------------------------------"
echo "Konvertiere ${file_name} von Pica3 nach Pica+"
echo "-------------------------------------"
echo

echo -e "Normalisieren"
# --- Normalisieren ---
./norm_pic3.sh ${file_name}

echo -e "csfn_fcvreversenorm, csfn_valnorm"
# --- Pica 3 zu Pica Plus ---
./pic3_to_pp ${file_name}

# --- Ausgabedateien in Arbeitsordner ---
mv *.txt ../output
mv *.pp ../output
 
echo
echo "##############################################################" 
echo " Pica Konvertierung beendet: $(date)" 
echo "##############################################################" 
echo