FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

#maj des packets et patch de securite

RUN apt-get install -y nginx openssl

#nginx= server web qui gerer les requetes http/s
#openssl loutil pour cree certif ssl/ tls (obliger pour https)

RUN mkdir -p /etc/nginx/ssl

#cree dossier ssl , pour stocker le certif ssl et private key

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=abkhefif.42.fr/UID=abkhefif"

#cmd pr cree demand de certificat auto assigned
# et a quel endroit le save 

COPY conf/nginx.conf /etc/nginx/nginx.conf

#replace la conf default de ngnx par la notre

RUN mkdir -p /var/run/nginx /var/www/wordpress

#cree dossier pour fichier temp de nginx 
#et dossier ou seront stock fils de site wordpress

RUN chown -R www-data:www-data /var/www/wordpress

#www-data est user default , on lui donne propriete
# de directory Wordpress pour lire les files

RUN chmod 755 /var/www/wordpress

#attribution des droit sur files

EXPOSE 443
# on expose le port 443 , seul port que notre infrastucture 
# doit accept selon sujet

CMD ["nginx", "-g", "daemon off;"]

# nginx = lance le server nginx 
# -g deamon off = force nginx a rester en premier plan
#par defaut ngninx se lance en arrier plan sinn contaner se stop

