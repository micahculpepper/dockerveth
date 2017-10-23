#!/bin/sh

containers=$(docker ps --format '{{.ID}} {{.Names}}')
addrs=$(ip address show)
mkdir -p /var/run/netns

if [ -t 1 ]; then
    printf "CONTAINER ID\tVETH       \tNAMES\n"
fi

IFS='
'
for c in $containers; do
    c_id="${c%% *}"
    c_name="${c#* }"
    c_pid=$(docker inspect --format '{{.State.Pid}}' "$c_id")
    ln  -sf "/proc/${c_pid}/ns/net" "/var/run/netns/ns-${c_pid}"
    c_ip_link_show=$(ip netns exec "ns-${c_pid}" ip link show type veth)
    c_eth_index="${c_ip_link_show%%:*}"
    ip_addr_link=$(echo "$addrs" | grep "@if${c_eth_index}")
    index_and_veth="${ip_addr_link%%@if${c_eth_index}*}"
    veth="${index_and_veth#* }"
    printf "${c_id}\t${veth}\t${c_name}\n"
done
