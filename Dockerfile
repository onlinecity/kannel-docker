FROM alpine:edge

RUN apk update && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ kannel


COPY kannel.conf /etc/kannel/kannel.conf
RUN ln /usr/bin/smsbox /usr/local/sbin/smsbox
RUN ln /usr/bin/bearerbox /usr/local/sbin/bearerbox

ENTRYPOINT ["/usr/sbin/bearerbox"]
CMD [ "/etc/kannel/kannel.conf" ]
