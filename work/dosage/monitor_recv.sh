#!/bin/sh

invalid_input()
{
    echo "Invalid Input: '$PNAME'"
    exit 1
}

read -p "Enter Process Name [default:dosagemgr] >> " PNAME
##[[ -z $PNAME ]] && invalid_input
[[ -z $PNAME ]] && PNAME="dosagemgr"

if [[ "$PNAME" =~ [[:space:]] ]]; then
    echo "Enter One Name" && invalid_input
fi

echo "Monitor Process '$PNAME'"
while [ true ]; do
    ps -ef | grep "$PNAME" | grep -v grep | grep -v tail | wc -l
    sleep 1
done
