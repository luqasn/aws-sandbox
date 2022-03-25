FROM debian:11.2-slim
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y curl awscli groff jq

ENTRYPOINT ["aws"]