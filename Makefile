# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ade-beco <ade-beco@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/10/15 17:26:50 by ade-beco          #+#    #+#              #
#    Updated: 2025/10/15 17:27:20 by ade-beco         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all : up

up :
	@docker-compose -f ./srcs/docker-compose.yml up -d

start :
	@docker-compose -f ./srcs/docker-compose.yml start

down :
	@docker-compose -f ./srcs/docker-compose.yml down

stop :
	@docker-compose -f ./srcs/docker-compose.yml stop

status :
	@ps -d
