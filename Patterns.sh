#!/bin/bash


#----------------
#Save the file location

#$read -p "Ingrese la ruta del archivo con la lista de las url con ataques(/home/.../..sh): " Ubication

#$read -p "Ingrese el dominio a analizar: "  dominio

#------------------
# Read and save the file information

#cat $(echo $Ubication) > test.csv
cat "$1.csv" > test.csv
#------------------


cat test.csv | cut -d '/' -f 4- | sort -u > Endfile.csv
rm test.csv


c=$(grep -on '[{/}]' ./Endfile.csv | cut -d ':' -f 1 | sort | tail -n 1 | cut -d ' ' -f 1)

rev ./Endfile.csv >  Endfile2.csv



for ((i=2;i<=$c;i++))
do

cat ./Endfile2.csv | cut -d '/' -f 1-$i | sort -u >> folders1.csv

done

cat folders1.csv | sort -u > file1.aux

#find the patterns more  recurrents

for j in $(cat file1.aux)

do

k=$(grep -o "$j" ./Endfile2.csv | wc -l)
echo $k" "$j >> file2.aux

done



rank=($(cat file2.aux | cut -d ' ' -f 1))
folder=($(cat file2.aux | cut -d ' ' -f 2 | rev)) #criterio de seleccion.
c=$(echo ${#rank[*]})

for  ((i=0;i<=$c;i++))
do

#echo ${rank[$i]}

if [[ $(echo ${rank[$i]}) -ge 2 ]]
then

echo ${folder[$i]} >> file3.aux

fi

done

cat file3.aux | sort -u >> Endfile.csv

cat Endfile.csv | sort -u  >> folders.csv

rm Endfile*
rm folders1.csv

#-----------------------------------
#Process to combine https, http, www and without www

com1="https://"
com2="http://"
com3="www."

awk '{print "/"$0}' folders.csv > file4.aux    #/ add a / at the beginning of the url.

sed 's/^/'$2'/' file4.aux > file5.aux #only the domain
sed 's/^/'$com3'/' file5.aux > file6.aux  #/ add www.

cat file6.aux >> file5.aux

awk '{print "http://"$0}' file5.aux > file7.aux  # add http://
awk '{print "https://"$0}' file5.aux >> file7.aux  # add https://

cat file7.aux | sort -u > folders.csv

rm *.aux
