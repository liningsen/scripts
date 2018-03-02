#!/bin/sh

read -p "Enter mode :[default:none/kcp/stop] [default:PHOENIX-0/SINGAPORE-1] >> " MODE LOCA
if [ "$MODE" = "kcp" ]; then
    echo "kcp mode"
    # sndwnd 128 rcvwnd 1024 -->>  50M bandwidth
    # sndwnd 256 rcvwnd 2048 -->> 100M bandwidth
    nohup ./kcptun-darwin-amd64-20170525/client_darwin_amd64 -l 127.0.0.1:8388 \
                                                             -r *SERV1_IP*:*KCP PORT* \
                                                             --crypt aes \
                                                             --key *KCP PASSWORD* \
                                                             --mtu 1400 \
                                                             --sndwnd 128 \
                                                             --rcvwnd 1024 \
                                                             --nocomp \
                                                             --mode fast2 \
                                                             --dscp 46 \
                                                             > /dev/null 2>kcptun_client.log &
    nohup ss-local -s 127.0.0.1 -p 8388 -k *SHADOWSOCKS_PASSWORD* -m aes-256-cfb -l 1080 -b 0.0.0.0 > /dev/null 2>shadowsocks_client.log &
    nohup ss-local -s *SERV1_IP* -p *SHADOWSOCKS_PORT* -k *SHADOWSOCKS_PASSWORD* -m aes-256-cfb -l 1080 -U -b 0.0.0.0 > /dev/null 2>shadowsocks_client.log &
elif [ "$MODE" = "stop" ]; then
    echo "stop mode"
    pkill client_darwin_amd64
    pkill ss-local
else
    echo "normal mode"
    if [ "$LOCA" = "1" ]; then
        echo "SINGAPORE"
        nohup ss-local -s *SERV2_IP* -p *SHADOWSOCKS_PORT* -k *SHADOWSOCKS_PASSWORD* -m aes-256-cfb -l 1080 -b 0.0.0.0 > /dev/null 2>shadowsocks_client.log &
    else
        echo "PHOENIX"
        nohup ss-local -s *SERV1_IP* -p *SHADOWSOCKS_PORT* -k *SHADOWSOCKS_PASSWORD* -m aes-256-cfb -l 1080 -b 0.0.0.0 > /dev/null 2>shadowsocks_client.log &
    fi
fi

echo "Client Mission Complete"
