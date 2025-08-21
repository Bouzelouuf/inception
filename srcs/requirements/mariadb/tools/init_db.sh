#!/bin/bash

service mariadb start
# Lance MySQL en arrière-plan
sleep 5
# Attendre 5 secs que MariaDB soit totalement démarré
# Sécurité pour les cmds suivantes

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
# Créer la base de données WordPress si elle n'existe pas déjà

mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# Créer l'utilisateur WordPress qui peut se connecter depuis n'importe où (%)

mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
# Donner tous les droits à l'utilisateur WordPress sur sa base de données

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# Changer le mot de passe root pour la sécurité

mysql -e "FLUSH PRIVILEGES;"
# Appliquer tous les changements de permissions

mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
# Arrêter MariaDB proprement avec le compte root

exec mysqld_safe
# Lancer MariaDB en processus principal du conteneur