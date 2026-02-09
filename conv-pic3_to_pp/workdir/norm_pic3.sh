#!/bin/bash

[[ -f ${1}.pica ]] || { echo >&2 "Can't read input file" ; exit 1 ; }

awk -vRS='\n\n' -vFS='\n' -vORS="" -vOFS="" '{ 

# RS=Record-Seperator FS=Field... ORS=Output... usw 
	# gsub(/\$/,"\037",$0) 	# bei PICA3 nicht vorhanden (OCT_037=DEC_31)
	print "\035\n" 		#DEC_29
	for (i=1; i<=NF; i++) { #NF=Feldanzahl
		print "\036",substr($i,1,5),substr($i,6),"\n"
#print "\036",substr($i,1,5),"\0370",substr($i,6),"\n"

# OCT_36=DEC_030
	}
}' "${1}.pica" >"${1}.pic3"
