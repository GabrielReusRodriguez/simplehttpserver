#ifndef SERVER_H
# define SERVER_H

# include <sys/socket.h>
# include <netinet/in.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <unistd.h>

typedef struct s_server
{
	int port;
	int domain;
	int service;
	int backlog;
	int protocol;
	u_long interface;

	struct sockaddr_in address;

	void (*launch)(struct s_server *server);

	int socket;
} t_server;


t_server server_constructor(\
		int domain, int service, int protocol, \
		u_long interface, int port, int backlog,\
		void(*launch)(t_server *server));

#endif
