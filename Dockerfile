FROM alpine:3.5

ADD https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt \
  /etc/ssl/certs/lets-encrypt-x3-cross-signed.pem
ADD https://raw.githubusercontent.com/onlinecity/wait-for-it/\
master/wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh
COPY svn-trust /etc/subversion/servers

RUN apk add --no-cache ca-certificates bash subversion \
  libxml2 pcre musl hiredis openssl \
  libxml2-dev pcre-dev build-base libtool musl-dev bison \
  hiredis-dev openssl-dev
RUN svn checkout --trust-server-cert --non-interactive -r 5329 https://svn.kannel.org/gateway/trunk \
  kannel-svn-trunk

WORKDIR /kannel-svn-trunk

RUN ln -sf /usr/include/poll.h /usr/include/sys/poll.h \
  && ln -s /usr/include/unistd.h /usr/include/sys/unistd.h \
  && ln -s /usr/share/libtool/build-aux/ltmain.sh /kannel-svn-trunk/ltmain.sh
RUN ./configure \
  --with-redis --enable-docs=no --enable-start-stop-daemon=no \
  --without-sdb --without-oracle --without-sqlite2
RUN make \
  && make install \
  && cp /kannel-svn-trunk/test/fakesmsc /usr/local/bin/
RUN apk del libxml2-dev pcre-dev build-base libtool musl-dev bison \
  hiredis-dev openssl-dev subversion \
  && rm -rf /kannel-svn-trunk && rm -rf /tmp/*

COPY kannel.conf /etc/kannel/kannel.conf

ENTRYPOINT ["/usr/local/sbin/bearerbox"]
CMD [ "/etc/kannel/kannel.conf" ]
