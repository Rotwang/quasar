CPPFLAGS += `curl-config --cflags`
CPPFLAGS += `xml2-config --cflags`
#CFLAGS += -MMD -Wall -Wextra -pedantic -ansi -ggdb3
CFLAGS += -MMD -Wall -Wextra -ggdb3
LDFLAGS += `curl-config --libs`
LDFLAGS += `xml2-config --libs`
OBJS := main.o quasar.o fetch.o parse.o

.PHONY: all clean

all: quasar

quasar: $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	-rm -rf *.o *.d quasar

-include $(wildcard *.d)
