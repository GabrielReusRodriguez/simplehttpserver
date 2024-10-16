NAME 		=	simplehttpserver

CC			=	gcc
# MMD Genera los ficheros de dependencia .d
# MP los agrega como PHONY
# con estas dos flags, controlamos los relinks y recompilaciones innecesarias. 
CFLAGS		=	-Wall -Werror -Wextra -MMD -MP
OBJ_DIR		=	./obj
SRC_DIR		=	./src
INC_DIR		=	./hdrs

SERVER_SRC	=	server.c	\
				test.c

SERVER_OBJS		=	$(patsubst %.c,${OBJ_DIR}/%.o,${SERVER_SRC})
SERVER_DEPS 	=	$(patsubst %.c,${OBJ_DIR}/%.d,${SERVER_SRC})

ifdef CSANITIZE
	CFLAGS	+= -fsanitize=address -fsanitize=leak
endif


all:	$(NAME)

$(NAME):	$(SERVER_OBJS) 
	$(CC) $(CFLAGS) $(SERVER_OBJS) -o $(NAME)

$(OBJ_DIR)/%.o	:	${SRC_DIR}/%.c Makefile
	@mkdir -p ${OBJ_DIR}
	$(CC) $(CFLAGS) -c $< -I${INC_DIR} -o $@

clean:
	rm -rf ${OBJ_DIR}

fclean: clean
	rm -rf ${NAME}

re: fclean all

#include de los ficheros de dependencias.
-include ${SERVER_DEPS}

.PHONY: all clean fclean re