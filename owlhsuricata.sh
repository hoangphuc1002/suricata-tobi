#!/bin/bash
set -o allexport
source .env
set +o allexport
mkdir /suricata && cd /suricata
echo "### CÀI ĐẶT CÁC GÓI PHỤ THUỘC ###"
apt-get update -y
apt-get install -y make libpcre2-dev build-essential autoconf automake libtool \
    libpcap-dev libnet1-dev libyaml-dev zlib1g-dev libcap-ng-dev libmagic-dev \
    libjansson-dev pkg-config libnetfilter-queue-dev libnfnetlink-dev \
    rustc cargo liblua5.1-dev libnspr4-dev libnss3-dev liblz4-dev \
    python3-yaml libhyperscan-dev

echo "### TẢI SOURCE VÀ CHẠY CONFIGURE ###"
wget "http://www.openinfosecfoundation.org/download/suricata-$VER.tar.gz" 
tar -xvzf "suricata-$VER.tar.gz" 
cd "suricata-$VER"
make distclean || true

./configure --enable-nfqueue --prefix=/usr --sysconfdir=/etc --localstatedir=/var
if [ $? -eq 0 ]; then
    echo "Đã chạy conf xong"
else
    echo "Lỗi rồi nè"
    exit 1
fi

make -j$(nproc)
sudo make install
sudo ldconfig

sudo mkdir -p /etc/suricata/
sudo cp /suricata/suricata-7.0.5/suricata.yaml /etc/suricata/
sudo cp /suricata/suricata-7.0.5/etc/*.config /etc/suricata/
sudo cp /suricata/suricata-7.0.5/etc/suricata.logrotate /etc/suricata/
sudo cp /suricata/suricata-7.0.5/threshold.config /etc/suricata/
