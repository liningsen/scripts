#/bin/sh

read -p "Enter mode: [default:start/stop] >> " MODE
if [ "$MODE" = "stop" ]; then
	echo "stop mode"
	pkill server_linux
	pkill ss-server
else
	echo "start mode"
	# sndwnd rcvwnd 1024 -->>  50M bandwidth
	# sndwnd rcvwnd 2048 -->> 100M bandwidth
	nohup ./kcptun/server_linux_amd64 -l :*KCP PORT* \
					  -t 127.0.0.1:*SHADOWSOCKS_PASSWORD* \
					  --crypt aes \
                      --key *KCP PASSWORD* \
					  --mtu 1400 \
					  --sndwnd 1024 \
					  --rcvwnd 1024 \
					  --nocomp \
                      --mode fast2 \
					  --dscp 46 \
					  > /dev/null 2>kcptun_server.log &
	nohup ss-server -s 0.0.0.0 -p *SHADOWSOCKS_PORT* -k *SHADOWSOCKS_PASSWORD* -m aes-256-cfb -u > /dev/null 2>shadowsocks_server.log &
fi

#nohup ./kcptun/server_linux_amd64 -l :*KCP PORT* -t 127.0.0.1:*SHADOWSOCKS_PASSWORD* --crypt aes --key *KCP PASSWORD* --mtu 1200 --nocomp --mode normal --dscp 46 > kcptun_server.log 2>&1 &
#nohup ss-server -s 0.0.0.0 -p *SHADOWSOCKS_PORT* -k *SHADOWSOCKS_PASSWORD* -m chacha20 -u > shadowsocks_server.log 2>&1 &

echo "Server Mission Complete"

