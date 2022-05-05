# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: clora-ro <clora-ro@student.42lyon.fr>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/21 16:54:47 by clora-ro          #+#    #+#              #
#    Updated: 2022/05/05 18:04:19 by clora-ro         ###   ########lyon.fr    #
#                                                                              #
# **************************************************************************** #

NAME 		= so_long

SRCS		=	action.c \
				checker_map_wall.c \
				checker_map.c \
				check_wall.c \
				main.c \
				map_init.c \
				map_read.c \
				move.c \
				position.c \
				get_next_line.c

OBJS		= $(SRCS:.c=.o)

CC			= gcc

DEBUG	= 	-fsanitize=address -g3
CFLAGS		= -Wall -Werror -Wextra
# make && leaks -atExit -- ./so_long map.ber

RM			= rm -f

CLEAN		= CLEAN

all			: libft minilibx $(NAME)

libft		:
			$(MAKE) -C libft

minilibx	:
			$(MAKE) -C minilibx

$(NAME)		: $(addprefix objs/, $(OBJS)) libft/libft.a minilibx/libmlx.a
			$(CC) $(CFLAGS) $(DEBUG) -o $(NAME) $^ -Lminilibx -lmlx -framework OpenGL -framework AppKit

objs/%.o	:	%.c includes/get_next_line.h includes/so_long.h libft/libft.h minilibx/mlx.h minilibx/mlx_int.h minilibx/mlx_new_window.h minilibx/mlx_opengl.h minilibx/mlx_png.h Makefile
				@mkdir -p objs
				$(CC) $(CFLAGS) $(DEBUG) -Iincludes -DBUFFER_SIZE=20 -c $< -o $@

			
clean		:
			rm -rf objs/
			make clean -C libft
			make clean -C minilibx

fclean		: clean
			rm -f $(NAME)
			make fclean -C libft

re			: fclean all
			make re -C libft
			make re -C minilibx

.PHONY		: all clean re fclean libft minilibx