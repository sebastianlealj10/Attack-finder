#!/bin/bash
#.......It is for take the time in the script exetution
start=`date +%s`
#....It saves the date
DATE=`date +%Y-%m-%d`
#....Remove all the folders for the last search
rm  "folders.csv" > /dev/null 2>&1
rm  "Posibleattack.csv" > /dev/null 2>&1
rm  "Proxyerror.csv" > /dev/null 2>&1
#....Asks for the domain
echo "Type the domain that you want to check, followed by [ENTER]:"
read domain
#.....Creates a file to save the domains
if [ ! -f "domainsrecords.csv" ]
  then
    echo "domain","Date" >> domainsrecords.csv
fi
#....Saves the processed domain
echo $domain,$DATE >> domainsrecords.csv
#....Aks for the client to analyze
echo "Type the client that you want to check[BancoGalicia], followed by [ENTER]:"
read client
#....The script only runs when the client has a database of Patterns
if [ ! -f "$client.csv" ]
  then
    echo "................."
    echo "Customer does not exist"
    echo "................."
    sleep 5
    exit
fi
#.....It calls to the George's script to make the patterns csv file
./Patterns.sh $client $domain
#.....It allows to Oxylabs set the proper proxy
echo "Type the country which the attack is from [Country Code], followed by [ENTER]:"
read country
#...Here there are a lot of conditions to choose: no proxy, Oxylabs or a Custom proxy, SOCKS are available
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
#The script is allowing type errors right now, it is something to fix
                sel_proxy="Custom"
                echo "Type the protocol [socks4], followed by [ENTER]:"
                read protocol
                echo "Type the ip [0.0.0.0],followed by [ENTER]:"
                read ip
                echo "Type the port [8080],followed by [ENTER]:"
                read port
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
#...URL to verify that the script is running well...
echo https://www.apachefriends.org/es/index.html >> folders.csv
echo URL > Posibleattack.csv
echo URL > Proxyerror.csv
#..............................This loop is used for read the URLS line by line
while read line
do
#...  ..Extracts the URLs from the csv
  URL=$(echo $line | cut -d, -f1)
  echo $URL
#......Select the proxy selected
  if [[ "$sel_proxy" == "Oxylabs" ]]
    then
#.......These parameters of cURL are optionals if you want to change something is ok but i put those for some reason
      resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                  --no-keepalive --insecure --connect-timeout 5 --output /dev/null --proxy http://customer-analyst-cc-"$country":CTAC%40cyxtera.com2018@pr.oxylabs.io:7777 )
      echo $resp
      echo $?
#...........This is really important, if the load is not complete the script tryes to do it again, Oxylabs use to fail a lot...
      if [ "$?" -ne 0 ] || [ "$resp" -eq 000 ]
        then
          resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                      --no-keepalive --insecure --connect-timeout 5 --output /dev/null --proxy http://customer-analyst-cc-"$country":CTAC%40cyxtera.com2018@pr.oxylabs.io:7777 )
      fi
      if [ "$?" -ne 0 ] || [ "$resp" -eq 000 ]
      then
#If the cURL is definitly not working the URL is sent to a list for manual checking
        echo $URL >> Proxyerror.csv
        continue
      fi
  fi
  if [[ "$sel_proxy" == "None" ]]
    then
      resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                  --no-keepalive --insecure --connect-timeout 5 --output /dev/null)
  fi
  if [[ "$sel_proxy" == "Custom" ]]
    then
      resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                  --no-keepalive --insecure --connect-timeout 5 --output /dev/null --proxy "$protocol"://"$ip":"$port")
    if [ "$?" -ne 0 ] || [ "$resp" -eq 000 ]
      then
        resp=$(curl $URL --write-out %{http_code} --progress-bar -L \
                --no-keepalive --insecure --connect-timeout 5 --output /dev/null --proxy "$protocol"://"$ip":"$port")
    fi
    if [ "$?" -ne 0 ] || [ "$resp" -eq 000 ]
      then
        echo $URL >> Proxyerror.csv
        continue
    fi
  fi
echo $res
#.........If the HTTP Response is 2XX or 3XX that counts like a posible attack, 3XX responses are not usual because -L of cURL find the last redirection.
  first_resp="${resp:0:1}"
  if [ $first_resp == 2 ] || [ $first_resp == 3 ]
    then
      echo $URL >> Posibleattack.csv
  fi
done <folders.csv
end=`date +%s`
runtime=$((end-start))
runtimeM=$((runtime/60))
#For check the script runtime
echo "Runtime was: " $runtimeM "minutes"
