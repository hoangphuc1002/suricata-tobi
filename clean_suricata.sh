#!/bin/bash
echo "###DỌN DẸP HỆ THỐNG###"
systemctl stop suricata || true
systemctl stop owlhnode || true

apt-get purge -y suricata
apt-get autoremove -y
apt-get clean

rm -rf /tmp/suricata-*

echo "Hệ thống đã sạch."