.PHONY: all clean
.DELETE_ON_ERROR:

CFLAGS := -ggdb3 -pipe -Wall -Wextra -MMD -std=c99
LDLIBS := -lgmp

all: solve_16

solve_16: solve_16.o

clean:
	-$(RM) solve_16.o *.d solve_16

-include $(wildcard *.d)
