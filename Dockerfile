FROM debian:bookworm-slim

RUN set -x \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		bind9 \
		dnsutils \
		iputils-ping \
	&& apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps \
	&& rm -r /var/lib/apt/lists/* \
	&& mkdir /var/log/named \
	&& chown bind:bind /var/log/named \
	&& chmod 0755 /var/log/named

COPY ./data/docker-entrypoint.sh /

EXPOSE 53
EXPOSE 53/udp


ENTRYPOINT ["/docker-entrypoint.sh"]
