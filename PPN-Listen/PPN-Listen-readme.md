Anfrage: 19 einzelne Listen mit PPNs derart miteinander vergleichen, dass nur die PPNs, die in ALLEN Listen enthalten sind, ermittelt werden.

Lösungsansatz: 
* alle PPNs in eine Datei schreiben
* Gesamtdatei sortieren und zählen
* PPN selektieren die 19 Mal vorkommen

cat *.txt > gesamt.txt

cat gesamt.txt | sort | uniq -c > gesamt_sort.txt

grep "19 " gesamt_sort.txt > weimar_all.txt

Die Summe steht dann noch vor jeder PPN, mit sed oder im Editor mit Suche / Ersetze bereinigen
