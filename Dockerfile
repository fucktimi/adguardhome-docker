FROM alpine:latest

RUN apk --no-cache --update add ca-certificates libcap tzdata curl && \
	rm -rf /var/cache/apk/* && \
	mkdir -p /opt/adguardhome/conf /opt/adguardhome/work && \
	curl -L -o adguard.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz && \
	 tar -xvzf adguard.tar.gz && \
	 cp -r /AdGuardHome/AdGuardHome /opt/adguardhome/ && \
	 chmod +x /opt/adguardhome/AdGuardHome && \
	 rm -rf AdGuardHome && \
	 rm -rf adguard.tar.gz

ADD AdGuardHome.yaml /opt/adguardhome/conf/AdGuardHome.yaml
ADD config.sh /config.sh
RUN chmod +x config.sh

EXPOSE 7035/tcp 7035/udp 3030/tcp
WORKDIR /opt/adguardhome/work

CMD /config.sh