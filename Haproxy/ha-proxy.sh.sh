#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common
sudo add-apt-repository ppa:vbernat/haproxy-2.6 -y
sudo apt update$ sudo apt install haproxy -y
haproxy -v
sudo systemctl status haproxy
sudo cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg-org
sudo vi /etc/haproxy/haproxy.cfg
-------------------------------
frontend front_smtp
        bind *:25
        mode tcp
        default_backend back_smtp

backend back_smtp
        mode tcp
        balance roundrobin
        server smtp1 192.168.1.10:25 check
        server smtp2 192.168.1.20:25 check
sudo systemctl restart haproxy
        