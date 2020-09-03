FROM debian:stable

RUN apt-get update && apt-get install -y incron ca-certificates

ADD incron.d /etc/incron.d
ADD entrypoint.sh /entrypoint.sh
ADD update.sh /update.sh

# clear cert list, we only want ours
RUN echo "" > /etc/ca-certificates.conf && update-ca-certificates

ENTRYPOINT ["/entrypoint.sh"]

CMD ["incrond", "-n"]