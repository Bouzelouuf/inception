FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y wget php7.4 php-fpm php-mysql mariadb-client

RUN wget https://wordpress.org/wordpress-6.0.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.0.tar.gz && rm wordpress-6.0.tar.gz

RUN  wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN printf '[www]\nuser = www-data\ngroup = www-data\nlisten = 9000\nlisten.owner = www-data\nlisten.group = www-data\npm = dynamic\npm.max_children = 5\npm.start_servers = 2\npm.min_spare_servers = 1\npm.max_spare_servers = 3\nclear_env = no\n' > /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/setup_wordpress.sh /usr/local/bin/setup_wordpress.sh

RUN chmod +x /usr/local/bin/setup_wordpress.sh

RUN chown -R www-data:www-data /var/www/wordpress

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/setup_wordpress.sh"]
