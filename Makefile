# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: buntakansirikamonthip <buntakansirikamonth +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/12 13:30:17 by buntakansirikamo  #+#    #+#              #
#    Updated: 2024/04/06 06:07:26 by buntakansirikamo ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception
DATA_PATH = home/$(USER)/data


all: create_dir $(NAME)

create_dir:
	mkdir -p $(DATA_PATH)/mariadb
	mkdir -p $(DATA_PATH)/wordpress

$(NAME): up


up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker exec -it wordpress sh -c "rm -rf /var/www/html/*"
	@docker exec -it mariadb sh -c "rm -rf /var/lib/mysql/*"
	@docker compose -f ./srcs/docker-compose.yml down

clean: down
	@echo "Cleaning up the environment..."
	@sudo docker compose -f $(COMPOSE_FILE) down
	@sudo docker stop $(docker ps -qa) 2>/dev/null || true
	@sudo docker rm $(docker ps -qa) 2>/dev/null || true
	@sudo docker rmi -f $(docker images -qa) 2>/dev/null || true
	@sudo docker volume rm $(docker volume ls -q) 2>/dev/null || true
	@sudo docker network rm $(docker network ls -q) 2>/dev/null || true

fclean: clean
	@docker system prune -af
	@docker volume prune -f
	@rm -rf $(DATA_PATH)

re: clean all

.PHONY: all create_dir $(NAME) up down clean re fclean

