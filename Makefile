NAME = simplehttpserver
CC=gcc
CFLAGS=-Wall -Werror -Wextra
SRC= server.c
TSRC = test.c
OBJS = server.o
TOBJS = test.o

all: $(NAME)

$(NAME):$(OBJS) $(TOBJS)
	$(CC) $(CFLAGS) $(OBJS) $(TOBJS) -o $(NAME)

%.o:%.c server.h Makefile
	$(CC) $(CFLAGS) -c $< -o $@
	

clean:
	rm -rf *.o

fclean: clean
	rm -rf $(NAME)

re: fclean all

