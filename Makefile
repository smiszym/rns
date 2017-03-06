CFLAGS += -Wall
CFLAGS += -g

.PHONY: all

all: rns

main.o: main.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns.o: rns.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns: main.o rns.o utils.o
	gcc ${CFLAGS} -o $@ $^
