CC = gcc
CFLAGS = -Wall -O2
LDFLAGS = 

TARGET = ipdump
SRCS = src/main.c src/capture.c src/protocol.c src/statistics.c src/filter.c
OBJS = $(SRCS:.c=.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJS) 