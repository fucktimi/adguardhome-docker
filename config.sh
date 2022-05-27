#!/bin/sh


chown -R nobody /opt/adguardhome
cd /opt/adguardhome/
./AdguardHome --no-check-update -c conf/AdguardHome.yaml -w /opt/adguardhome/work