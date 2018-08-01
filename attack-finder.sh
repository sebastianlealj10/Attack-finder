#!/bin/bash
#.............................................Function to set the proper proxy, get the body and HTTP response form the URL
set_proxy () {
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
