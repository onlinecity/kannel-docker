FROM debian:bullseye AS builder

RUN apt-get update && apt-get install -y kannel


COPY kannel.conf /etc/kannel/kannel.conf

ENTRYPOINT ["/usr/sbin/bearerbox"]
CMD [ "/etc/kannel/kannel.conf" ]
