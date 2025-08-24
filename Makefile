NAME = inception

COMPOSE=docker compose -f srcs/docker-compose.yml

all: up

up:
	@$(COMPOSE) up -d --build

down:
	@$(COMPOSE) down

clean:
	@$(COMPOSE) down --volumes

fclean:
	@docker rmi -f $$(docker images -q ${NAME}-*) || true

.PHONY: all up down clean fclean
