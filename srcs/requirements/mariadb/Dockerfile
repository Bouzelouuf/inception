FROM debian:bullseye

#//cette ligne ffonctionne depuis ce OS 
# mais avec une image plus lgere et simplifier de los 
#uniquement ce quon a besoin 
#si limage nest pas dispo il la dl depuis DockerHub

RUN apt-get update && apt-get upgrade -y

#//met a jour la list des paquet et , met a jour 

RUN apt-get install -y mariadb-server

#// -y (yes) , pour install le mariadb server 

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#//important , cette ligne prends un file sur ordi a gauche
#et la place dans le conteneur a droite

COPY tools/init_db.sh /usr/local/bin/init_db.sh
#first, copy du script d'init dans container
RUN chmod +x /usr/local/bin/init_db.sh
#puis perm pour d'exec avec chmod

EXPOSE 3306

#signifie ce container a but duse le port 3306
#comme un panneau de numero dadresse dune maison inscrit sur la maison

ENTRYPOINT ["/usr/local/bin/init_db.sh"]

#definit quelle cmd sera exec qd container demarre  ! CRUCIAL
#cette cmd devient le procss principal du container
#tant que ce procss run  = container vivant