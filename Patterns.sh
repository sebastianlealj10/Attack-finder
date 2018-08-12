#!/bin/bash

if [[ -n  $(ls -l | grep "folders.csv") ]]
then
 rm folders.csv
fi


#----------------
#Save the file location

#read -p "Ingrese la ruta del archivo con la lista de las url con ataques(/home/.../..sh): " Ubication

#read -p "Ingrese el dominio a analizar: "  dominio

cat "$1.csv" > test.csv
#------------------
# Read and save the file information

#cat $(echo $Ubication) |  sed 's/\"//g' > test.csv

#------------------
# Delete those urls that belong to redirect services as bit.ly goo.gl ht.ly owl.li bit.do among other that we have to check

cat test.csv | grep -vi "bit.ly\|goo.gl\|ht.ly\|owl.li\|bit.do\|ow.ly" >test2.csv

#---------------------

cat test2.csv | cut -d '/' -f 4- | sort -u > Endfile.csv
rm test.csv
rm test2.csv

c=$(grep -on '[{/}]' ./Endfile.csv | cut -d ':' -f 1 | sort | tail -n 1 | cut -d ' ' -f 1) #Maximum numbers of folders.

rev ./Endfile.csv >  Endfile2.csv



for ((i=2;i<=$c;i++))
do

cat ./Endfile2.csv | cut -d '/' -f 1-$i | sort -u >> folders1.csv

done

cat folders1.csv | sort -u > file1.aux

#find the most frecuently patterns

for j in $(cat file1.aux)

do

k=$(grep -o "$j" ./Endfile2.csv | wc -l)
echo $k" "$j >> file2.aux

done



rank=($(cat file2.aux | cut -d ' ' -f 1))
folder=($(cat file2.aux | cut -d ' ' -f 2 | rev)) #Selection criteria
c=$(echo ${#rank[*]})

for  ((i=0;i<=$c;i++))
do

#echo ${rank[$i]}

if [[ $(echo ${rank[$i]}) -ge 2 ]]
then

echo ${folder[$i]} >> file3.aux #Save the folders according with the selecction criteria

fi

done

cat file3.aux | sort -u >> Endfile.csv

cat Endfile.csv | sort -u  >> folders.csv

rm Endfile*
rm folders1.csv

#-----------------------------------
#Process to combine https, http, www and without www

com1=https://
com2=http://
com3=www.

awk '{print "/"$0}' folders.csv > file4.aux    #/ add a / at the beginning of the url.

sed 's/^/'$2'/' file4.aux > file5.aux #only the domain
sed 's/^/'$com3'/' file5.aux > file6.aux  #/ add www.

cat file6.aux >> file5.aux

awk '{print "http://"$0}' file5.aux > file7.aux  # add http://
awk '{print "https://"$0}' file5.aux >> file7.aux  # add https://

cat file7.aux | sort -u | sed 's/\"//g' | sed 's/\r//g' > folders.csv

rm *.aux

#echo "El resultado se encuentra en el archivo folders.csv ubicación:" $(pwd folders.csv)

