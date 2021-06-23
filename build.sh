#!/bin/bash
# Construir el archivo de flags de acuerdo a los parametrose
LENG="esp";
RI="nri";
for p in $@;
do
	if [ "$p" = "-eng" ];
	then
		LENG="eng"
	fi
done
echo "\newboolean{esp}" > flags.tex
if [ "$LENG" = "esp" ];
then
	echo "\setboolean{esp}{true}" >> flags.tex 
else
	echo "\setboolean{esp}{false}" >> flags.tex 
fi
echo "\newboolean{doResearchInterests}" >> flags.tex
if [ "$RI" = "dri" ];
then
	echo "\setboolean{doResearchInterests}{true}" >> flags.tex 
else
	echo "\setboolean{doResearchInterests}{false}" >> flags.tex 
fi

#
# Construir el latex
pdflatex CV.tex -interaction nonstopmode
pdflatex CV.tex -interaction nonstopmode
bibtex int
bibtex inv
bibtex jou
bibtex bok
bibtex wor
pdflatex CV.tex -interaction nonstopmode
pdflatex CV.tex -interaction errorstopmode
#
# Dejar el archivo de flags vacio
echo "" >flags.tex
