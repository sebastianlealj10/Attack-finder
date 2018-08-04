#!/bin/bash
#.............................................Function to set the proper proxy, get the body and HTTP response form the URL
set_proxy_Oxylabs () {
  case $1 in
    USA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-US:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    BRAZIL)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-BR:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    CHILE)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-CL:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    MEXICO)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-MX:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    JAPAN)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-JP:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    PERU)
      curl $2 -# -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-PE:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    ARGENTINA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-AR:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    BOLIVIA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-BO:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    DOMINICANREPUBLIC)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-DO:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    *)
      curl $2 -# -k -L -w,--progress-bar --insecure --write-out "\n%{http_code}"> $3
      ;;
  esac
}

set_proxy_Custom () {
  case $1 in
    USA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-US:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    BRAZIL)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-BR:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    CHILE)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-CL:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    MEXICO)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-MX:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    JAPAN)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-JP:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    PERU)
      curl $2 -# -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-PE:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    ARGENTINA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-AR:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    BOLIVIA)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-BO:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    DOMINICANREPUBLIC)
      curl $2 -# -k -L -w -x,--progress-bar --insecure --write-out "\n%{http_code}" --proxy http://customer-analyst-cc-DO:CTAC%40cyxtera.com2018@pr.oxylabs.io:7777> $3
      ;;
    *)
      curl $2 -# -k -L -w,--progress-bar --insecure --write-out "\n%{http_code}"> $3
      ;;
  esac
}

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
#./Patterns.sh $client $domain
echo "Type the country which the attack is from [Country Code], followed by [ENTER]:"
read country
echo "Do you want to use proxy?, [Y/N] followed by [ENTER]:"
read ans1
if [ "$ans1" == "Y" ]
  then
    echo "Do you want to use Oxylabs?, [Y/N] followed by [ENTER]:"
    read ans2
    if [ "$ans2" == "Y" ]
      then
        sel_proxy="Oxylabs"
      else
        sel_proxy="Custom"
    fi
   else
    sel_proxy="None"
fi
if [ $ans1 != "Y" || $ans2 != "N" ] || [ $ans1 != "N" || $ans2 != "Y" ] || [ $ans1 != "Y" || $ans2 != "Y" ]
  then
    exit
fi
#while read line
#do
#URL=`echo $line | cut -d, -f1`
#echo $URL
#done <folders.csv
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
