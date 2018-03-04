#!/bin/sh

pid=${1:-""}
key=${2:-"5-6"}

echo "pid : "$pid
echo "key : "$key

if [ "$pid" = "" ]; then
    echo "ALL FILES"
    grep "Analyze $key" dosagemgr*.log | head -n 5
    grep "Analyze $key" dosagemgr*.log | head -n 5 | \
    awk '
    BEGIN {
        FS = "_| "
    }
    {
        t = $3
        v1 = $12
        v2 = $13
        if ($key ~ /pure/) {
            print t, " ", v2
        } else {
            if (v1 ~ /^[0-9]+$/) {
                print t, " ", v1
            } else {
                print t, " ", v2
            }
        }
    }
    END {
    }
    '
else
    echo "FILE : dosagemgr_"$pid".log"
    ls dosagemgr_$pid.log > /dev/null
    if [ $? != 0 ]; then
        echo "GREP FAILURE"
        exit 1
    fi

    grep "Analyze $key" dosagemgr_$pid.log | head -n 5
    grep "Analyze $key" dosagemgr_$pid.log | head -n 5 | \
    awk '
    BEGIN {
        FS = "_| "
    }
    {
        t  = $2
        v1 = $11
        v2 = $12
        if ( $key ~ /pure/) {
            print t, " ", v2
        } else {
            if ( v2 ~ /^[0-9]+$/) {
                print t, " ", v2
            } else {
                print t, " ", v1
            }
        }
    }
    END {
    }
    '
fi
