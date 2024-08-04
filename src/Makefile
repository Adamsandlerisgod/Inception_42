# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: whendrik <whendrik@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/07/08 16:57:22 by whendrik           #+#    #+#              #
#    Updated: 2024/07/26 16:39:27 by whendrik          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
#                                     VARS                                     #
# **************************************************************************** #

END				=	\033[0m

# COLORS
BLACK			=	\033[0;30m
RED				=	\033[0;31m
GREEN			=	\033[0;32m
ORANGE			=	\033[0;33m
BLUE			=	\033[0;34m
PURPLE			=	\033[0;35m
CYAN			=	\033[0;36m
LIGHT_GRAY		=	\033[0;37m
DARK_GRAY		=	\033[1;30m
LIGHT_RED		=	\033[1;31m
LIGHT_GREEN		=	\033[1;32m
YELLOW			=	\033[1;33m
LIGHT_BLUE		=	\033[1;34m
LIGHT_PURPLE	=	\033[1;35m
LIGHT_CYAN		=	\033[1;36m
WHITE			=	\033[1;37m

# **************************************************************************** #
#                                   COMMAND                                    #
# **************************************************************************** #

DOCKER_COMPOSE := $(shell \
    if command -v docker compose > /dev/null 2>&1; then \
        echo "docker compose"; \
    else \
        echo "docker-compose"; \
    fi)
# **************************************************************************** #
#                                   SOURCES                                    #
# **************************************************************************** #

SRCS_PATH 		=	 ./srcs

DOCKER_COMPOSE_FILE = $(SRCS_PATH)/docker-compose.yml

HOSTS_TO_ADD 	:= whendrik.42.fr adminer.whendrik.42.fr naegativ.whendrik.42.fr cadvisor.whendrik.42.fr

# **************************************************************************** #
#                                   VOLUME                                     #
# **************************************************************************** #

USER_HOME = $(shell echo ~)

# **************************************************************************** #
#                                    RULES                                     #
# **************************************************************************** #

all: check_docker check_env host create_volumes up

up:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build 

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans

re: down up

logs:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans --rmi all

fclean: clean
	@ rm -rd $(USER_HOME)/data/mysql
	@ rm -rd $(USER_HOME)/data/wordpress

# Sub rules
create_volumes:
	@echo "$(YELLOW)Creating volumes (in $(USER_HOME)/data)...$(END)"
	@mkdir -p $(HOME)/data
	@mkdir -p $(HOME)/data/mysql
	@mkdir -p $(HOME)/data/wordpress
	# @ chown -R $(USER) $(HOME)/data
	# @ chmod -R 777 $(HOME)/data

host:

check_env:
	@if [ ! -f $(SRCS_PATH)/.env ]; then \
		echo "$(RED)Error: .env file not found!$(END)"; \
		exit 1; \
	fi

check_docker:
	@if ! docker --version > /dev/null 2>&1; then \
		echo "$(RED)Error: Docker not installed!$(END)"; \
		exit 1; \
	fi

	@if ! $(DOCKER_COMPOSE) --version > /dev/null 2>&1; then \
		echo "$(RED)Error: Docker Compose not installed!$(END)"; \
		exit 1; \
	fi

.PHONY: all up down re clean fclean
