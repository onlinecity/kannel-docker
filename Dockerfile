FROM debian:bullseye-slim AS builder

RUN apt-get update && apt-get install -y kannel=1.4.5-9


COPY kannel.conf /etc/kannel/kannel.conf
RUN mkdir -p /usr/local/sbin
RUN ln /usr/sbin/smsbox /usr/local/sbin/smsbox
RUN ln /usr/sbin/bearerbox /usr/local/sbin/bearerbox

ENTRYPOINT ["/usr/sbin/bearerbox"]
CMD [ "/etc/kannel/kannel.conf" ]
