COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/abkhefif/data

all: build up

build:
	sudo mkdir -p $(DATA_PATH)/wordpress
	sudo mkdir -p $(DATA_PATH)/mariadb
	sudo chown -R abkhefif:abkhefif $(DATA_PATH)
	# Build toutes les images Docker depuis les Dockerfiles
	# -f : spécifie le fichier docker-compose à utiliser
	docker-compose -f $(COMPOSE_FILE) build

up:
	# -d : mode détaché, tourne en arrière-plan
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	docker-compose -f $(COMPOSE_FILE) down

clean: down
	docker system prune -af
	docker volume prune -f
	sudo rm -rf $(DATA_PATH)

re: clean all

.PHONY: all build up down clean re