#!/bin/sh

pid=${1:-""}
key=${2:-"5-6"}

if [ "$pid" = "" ]; then
    grep "Analyze $key" dosagemgr*.log | \
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
    ls dosagemgr_$pid.log > /dev/null
    if [ $? != 0 ]; then
        echo "GREP FAILURE"
        exit 1
    fi

    grep "Analyze $key" dosagemgr_$pid.log | \
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
