#include "server.h"

void launch(t_server *server)
{
	int addr_lgt;
	int new_socket;
	char buffer[30000] = {0};

	while (1)
	{
		printf("=== Waiting for Connection ===\n");
		addr_lgt = sizeof(server->address);
		new_socket = accept(server->socket, (struct sockaddr *)&server->address, (socklen_t *)&addr_lgt);
		read(new_socket, buffer, 30000);
		printf("%s\n", buffer);
		char *hello = "HTTP/1.1 200 OK\nDate: Mon, 27 Jul 2009 12:28:53 GMT\nServer: Apache/2.2.14 (Win32)\nLast-Modified: Wed, 22 Jul 2009 19:15:56 GMT\nContent-Length: 88\nContent-Type: text/html\nConnection: Closed\n<html><body><h1>Homo Erectus</h1></body></html>";
		
		write(new_socket, hello, strlen(hello));
	}
	close(new_socket);
}

int main()
{
	t_server server = server_constructor(AF_INET, SOCK_STREAM, 0, INADDR_ANY, 80, 10, launch);
	server.launch(&server);
}
