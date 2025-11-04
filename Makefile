# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ade-beco <ade-beco@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/15 17:26:50 by ade-beco          #+#    #+#              #
#    Updated: 2025/10/15 18:19:57 by ade-beco         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : up

up :
	@docker-compose -f srcs/docker-compose.yml up -d

down :
	@docker-compose -f srcs/docker-compose.yml down

start :
	@docker-compose -f srcs/docker-compose.yml start

stop :
	@docker-compose -f srcs/docker-compose.yml stop

status :
	@docker ps
