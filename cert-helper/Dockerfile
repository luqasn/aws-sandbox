FROM debian:stretch

RUN apt-get update && apt-get install -y ca-certificates

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]