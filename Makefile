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
	@docker rmi mariadb_image nginx_image wordpress_image

fclean: clean
	@docker system prune -af
	@docker volume prune -f
	@rm -rf $(DATA_PATH)

re: clean all

.PHONY: all create_dir $(NAME) up down clean re fclean

