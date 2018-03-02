#!/bin/sh

invalid_input()
{
    echo "Invalid Input: '$1' "
#    exit 1
}

#read -p "Enter send threads Num >> " TNUM
#read -p "Enter recv process Num >> " PNUM
read -p "Enter Group Count Num (RECOMMEND INPUT 20)>> " GNUM
read -p "Enter BillingCycle like 201708 >> " BillingCycle

#[[ -z $TNUM || -z $PNUM ]] && invalid_input $TNUM $PNUM
[[ -z $GNUM ]] && invalid_input $GNUM && exit 1
[[ -z $BillingCycle ]] && invalid_input $BillingCycle && exit 1

#if [[ "$TNUM" =~ ^-?[[:digit:]]+$ &&
#      "$PNUM" =~ ^-?[[:digit:]]+$ ]]; then
if [[ "$GNUM" =~ ^-?[[:digit:]]+$ &&
      "$BillingCycle" =~ ^-?[[:digit:]]+$ ]]; then
    if (( "GNUM" >= 1 )); then
        echo $GNUM
        echo $BillingCycle
        i=0
        while [ $i -lt $GNUM ]; do
            echo "<========  Group $i start  ========>"

            j=0
            while [ $j -lt 15 ]; do
                echo "$j recv process start"
                nohup ./dosagemgr -f ~/cloud/etc/dbconnect.xml \
                                  -f ./PublicParam_mgr.ini \
                                  -O 512000002 \
                                  -m 1 \
                                  -g $i &
                sleep 1
                j=$(($j + 1))
            done

            echo "send process start"
            nohup ./dosageservcycle -f ~/cloud/etc/dbconnect.xml \
                                    -f ./PublicParam_serv.ini \
                                    -O 512000002 \
                                    -d 0 \
                                    -b $BillingCycle \
                                    -t 1 \
                                    -g $i \
                                    -c $GNUM &
            sleep 1

            i=$(($i + 1))
        done

        echo "Start Complete"
        exit 0
    else
        echo "Enter Integer >= 1" && invalid_input $GNUM
        echo "Enter Valid Date like 201708 " && invalid_input $BillingCycle
        exit 1
    fi
else
    echo "Enter A Integer like 1" && invalid_input $GNUM
    echo "Enter Valid Date like 201708 " && invalid_input $BillingCycle
    exit 1
fi


