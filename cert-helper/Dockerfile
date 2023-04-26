FROM debian:stretch

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt-get update && apt-get install -y ca-certificates

ADD entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]
