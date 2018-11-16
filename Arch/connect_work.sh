ip route del 192.168.206.0 dev enp0s31f6
ip address del 192.168.206.135/24 dev enp0s31f6
ip link set enp0s31f6 down
ip address add 192.168.206.135/24 broadcast + dev enp0s31f6
ip link set enp0s31f6 up
ip route add 192.168.206.0 dev enp0s31f6
