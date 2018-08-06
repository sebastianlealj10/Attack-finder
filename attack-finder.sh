#!/bin/bash
start=`date +%s`
rm  "folders.csv" > /dev/null 2>&1
rm  "Posibleattack.csv" > /dev/null 2>&1
rm  "Proxyerror.csv" > /dev/null 2>&1
echo "Type the domain that you want to check, followed by [ENTER]:"
read domain
echo "Type the client that you want to check[BancoGalicia], followed by [ENTER]:"
read client

if [ ! -f "$client.csv" ]
  then
    echo "................."
    echo "Customer does not exist"
    echo "................."
    sleep 5
    exit
fi
./Patterns.sh $client $domain
echo "Type the country which the attack is from [Country Code], followed by [ENTER]:"
read country
echo "Do you want to use proxy?, [Y/N] followed by [ENTER]:"
read ans1
if [[ "$ans1" == "Y" || "$ans1" == "N" ]]
  then
    if [ "$ans1" == "Y" ]
      then
        echo "Do you want to use Oxylabs?, [Y/N] followed by [ENTER]:"
        read ans2
        if [[ "$ans2" == "Y" || "$ans2" == "N" ]]
          then
            if [ "$ans2" == "Y" ]
              then
                sel_proxy="Oxylabs"
              else
                sel_proxy="Custom"

            fi
          else
            echo "error"
      fi
    else
      sel_proxy="None"
    fi
    else
    echo "error"
fi
echo $sel_proxy
echo https://www.apachefriends.org/es/index.html >> folders.csv
echo URL > Posibleattack.csv
echo URL > Proxyerror.csv
while read line
do
  URL=`echo $line | cut -d, -f1`
  if [[ "$sel_proxy" == "Oxylabs" ]]
    then

      resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                  --no-keepalive --insecure --output /dev/null --proxy http://customer-analyst-cc-"$country":CTAC%40cyxtera.com2018@pr.oxylabs.io:7777 )
      echo $resp
      if [ "$?" -ne 0 ]
        then
          resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                      --no-keepalive --insecure --output /dev/null --proxy http://customer-analyst-cc-"$country":CTAC%40cyxtera.com2018@pr.oxylabs.io:7777 )
      fi
      if [ "$?" -ne 0 ]
      then
        echo $URL >> Proxyerror.csv
      fi
  fi
  if [[ "$sel_proxy" == "None" ]]
    then
      resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                  --no-keepalive --insecure --output /dev/null)
  fi
  if [[ "$sel_proxy" == "Custom" ]]
    then
      echo "................"
      echo "this function is not available yet"
      echo "................"
      sleep 5
      exit
  fi
#curl $google.com --write-out %{http_code} --progress-bar -L --no-keepalive --insecure --output /dev/null
  first_resp="${resp:0:1}"
  if [ $first_resp == 2 ] || [ $first_resp == 3 ]
    then
      echo $URL >> Posibleattack.csv
  fi
done <folders.csv
end=`date +%s`
runtime=$((end-start))
runtimeM=$((runtime/60))
echo "el tiempo de ejecución fue: " $runtimeM "minuts"
#URL="https://gist.github.com"
#country="US"
#resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
#                  --no-keepalive --insecure --output /dev/null --proxy http://customer-analyst-cc-"$country":CTAC%40cyxtera.com2018@pr.oxylabs.io:7777 )
#echo $resp
#custom
#protocol="socks4"
#ip="146.252.240"
#port="59310"
#resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
#                  --no-keepalive --insecure --output /dev/null --proxy "$protocol"://"$ip":"$port")

#echo $resp

#user-agent


#set_proxy $COUNTRY $URL "newsite.html"
#if [ "$?" -ne 0 ]
#  then
#    set_proxy $COUNTRY $URL "newsite.html"
#fi
#if [ "$?" -ne 0 ]
#  then
#    cat HTMLS/$ID.html > "newsite.html"
#fi
