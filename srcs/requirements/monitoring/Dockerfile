FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    netcat-openbsd \
    && apt-get clean

COPY monitor.sh /usr/local/bin/monitor.sh
RUN chmod +x /usr/local/bin/monitor.sh

CMD ["/usr/local/bin/monitor.sh"]