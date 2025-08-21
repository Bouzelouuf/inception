#!/bin/bash

sleep 10

cd /var/www/wordpress

# Si WordPress n'est pas encore configuré
if [ ! -f wp-config.php ]; then
    
    # Créer le fichier de configuration wp-config.php avec les infos de la DB
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --path='/var/www/wordpress'

    # Installer WordPress : créer les tables, admin, etc.
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="Mon Site Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --path='/var/www/wordpress'

    # Créer un utilisateur standard (non-admin) comme demandé dans le sujet
    wp user create --allow-root \
        $WP_USER \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD \
        --path='/var/www/wordpress'

# Fin du if
fi

if [ ! -f /var/www/wordpress/wp-content/object-cache.php ]; then
    echo "configuration Redis Cache..."

#install le plugin Redis Object cache
    wp plugin install redis-cache --activate --allow-root --path='/var/www/wordpress'
    
#ajout la config Redis dans wp config.php
    wp config set WP_REDIS_HOST 'redis' --allow-root --path='/var/www/wordpress'
    wp config set WP_REDIS_PORT 6379 --allow-root --path='/var/www/wordpress'
    wp config set WP_REDIS_DATABASE 0 --allow-root --path='/var/www/wordpress'

#activ redis cache
    wp redis enable --allow-root --path='/var/www/wordpress'

    echo "Configuration Redis finish"
fi

# Créer le dossier pour PHP-FPM si il n'existe pas
if [ ! -d /run/php ]; then
    mkdir /run/php
fi

# Lancer PHP-FPM en premier plan (processus principal du conteneur)
exec /usr/sbin/php-fpm7.4 -F