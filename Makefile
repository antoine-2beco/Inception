# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ade-beco <ade-beco@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/15 17:26:50 by ade-beco          #+#    #+#              #
#    Updated: 2025/11/17 19:22:45 by ade-beco         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : build up

build :
	@docker-compose -f srcs/docker-compose.yml build --no-cache

up :
	@docker-compose -f srcs/docker-compose.yml up -d

down :
	@docker-compose -f srcs/docker-compose.yml down -v

start :
	@docker-compose -f srcs/docker-compose.yml start

stop :
	@docker-compose -f srcs/docker-compose.yml stop

status :
	@docker ps