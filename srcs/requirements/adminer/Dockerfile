FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y php7.4 php7.4-mysql wget

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php -O /var/www/adminer.php

WORKDIR /var/www

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "adminer.php"]