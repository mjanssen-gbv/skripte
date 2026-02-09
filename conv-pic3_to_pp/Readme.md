TIB_SAK:
Dateien zusammen fassen

CBST7:

Konvertierung:

norm_pic3.sh - erzeugt *.pic3 	(filename ohne Extension als Parameter)
pic3_to_pp - erzeugt *.pp	(filename ohne Extension als Parameter)

Überprüfung der *.pp-Datei auf doppelt vergebene ID (Komma in Indexdatei)

// derzeit nicht relevant
   MM-Test (auf CBST7 nicht aussagekräftig, da nicht in 1.1 eingespielt wird):
   storen in 1.149 mit setvar_store_TIP_SAK_149
---
   ~/utils/store/store 89_2020-05-27_Scanner.pp -v setvar_store_TIB_SAK_149
---
   mm_tib_sak_cbst7.ksh (IPNs und filename anpassen!) im Dummymodus -> MM-Testergebnis
   getrennt nach new / merge / mark
// nicht relevant

CBSX:

MM-Test:
mmtest_storemm-dummy-cbsx (Dateinamen eintragen) -> MM-Testergebnis in Gesamtdatei

   falls nicht alle "new": storen in 1,41 mit setvar_store_TIP_SAK_149 / mm_tib_sak_cbsx.ksh 
   (IPNs und filename anpassen!) im Dummymodus -> getrenntes MM-Testergebnis)

Falls es Treffer gibt, werden diese nur markiert. -> nachschauen, wahrscheinlich wurden die Titel doppelt geliefert.

Storen in 1.1:

Ordner /export/home/cbsx_import/IBD/0089_TIB_SAK

~/utils/store/store 89_Scanner_21-01-27.pp -v setvar_store_TIB_SAK