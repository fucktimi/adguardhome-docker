FROM alpine:latest

RUN apk --no-cache --update add ca-certificates libcap tzdata curl && \
	rm -rf /var/cache/apk/* && \
	mkdir -p /opt/adguardhome/work && \
    curl -L -o adguard.tar.gz https://github.com/AdguardTeam/AdGuardHome/releases/latest/download/AdGuardHome_linux_amd64.tar.gz && \
	curl -L -o AdGuardHome.yaml https://raw.githubusercontent.com/fucktimi/adguardhome-docker/main/AdGuardHome.yaml && \
	tar -xvzf adguard.tar.gz && \
	cp -r /AdGuardHome/AdGuardHome /opt/adguardhome/ && \
	cp -r AdGuardHome.yaml /opt/adguardhome/AdGuardHome.yaml && \ 
	chown -R nobody /opt/adguardhome && \
	chmod +x /opt/adguardhome/AdGuardHome && \
	rm -rf AdGuardHome && \
	rm -rf adguard.tar.gz && \
	rm -rf AdGuardHome.yaml && \
    setcap 'cap_net_bind_service=+eip' /opt/adguardhome/AdGuardHome

EXPOSE 5335/udp 3030/tcp
WORKDIR /opt/adguardhome/work
ENTRYPOINT ["/opt/adguardhome/AdGuardHome"]

CMD [ \
	"--no-check-update", \
	"-c", "/opt/adguardhome/AdGuardHome.yaml", \
	"-h", "0.0.0.0", \
	"-w", "/opt/adguardhome/work" \
]