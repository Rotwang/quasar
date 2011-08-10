CC = gcc
CPPFLAGS += `curl-config --cflags`
CFLAGS += -MMD -Wall -Wextra -pedantic -ansi -ggdb3
LDFLAGS += `curl-config --libs`

.PHONY: all

all: quasar

quasar: quasar.o
	$(CC) -o $@ $< $(LDFLAGS)

clean:
	rm -f *.o quasar

-include $(wildcard *.d)