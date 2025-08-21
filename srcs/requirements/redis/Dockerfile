FROM debian:bullseye

# Mise à jour du système
RUN apt-get update && apt-get upgrade -y

# Installation Redis
RUN apt-get install -y redis-server

# Trouver et modifier le fichier de config Redis
# Sur Debian, il est dans /etc/redis/redis.conf
RUN find /etc -name "redis.conf" -type f -exec sed -i 's/bind 127.0.0.1/bind 0.0.0.0/' {} \;

# Alternative : créer notre propre config simple
RUN echo "bind 0.0.0.0" > /etc/redis/redis.conf && \
    echo "port 6379" >> /etc/redis/redis.conf && \
    echo "protected-mode no" >> /etc/redis/redis.conf && \
    echo "daemonize no" >> /etc/redis/redis.conf

# Port Redis
EXPOSE 6379

# Lancer Redis avec notre config
CMD ["redis-server", "/etc/redis/redis.conf"]