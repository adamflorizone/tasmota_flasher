data=`cat | tr '\n' ' '`;

echo "$data\n"

stty -F "$1" "$2" raw -echo
exec 99<>"$1"
    
    echo "$data\n" >&99

    read answer <&99
    echo $answer

    sleep 2
exec 99>&-