FROM debian:stretch

RUN apt-get update && apt-get install -y ca-certificates

ADD entrypoint.sh /entrypoint.sh
ADD update.sh /update.sh

CMD ["/entrypoint.sh"]