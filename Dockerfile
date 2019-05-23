FROM mongo:4.0.9

RUN apt-get update \
 && apt-get install --yes curl \
 && curl -fsSL https://dl.min.io/client/mc/release/linux-amd64/mc > /usr/bin/mc \
 && chmod +x /usr/bin/mc \
 && apt-get remove --yes curl \
 && apt-get clean

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
