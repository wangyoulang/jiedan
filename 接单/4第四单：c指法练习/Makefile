CC = gcc
CFLAGS = -Wall -g -v

typing_game: typing_game.c game.c user.c
	$(CC) $(CFLAGS) typing_game.c game.c user.c -o typing_game.exe

clean:
	del typing_game.exe 