CFLAGS += -Wall
CFLAGS += -g

.PHONY: all

all: rns

main.o: main.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_add.o: rns_add.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_sub.o: rns_sub.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns: main.o rns_add.o rns_sub.o utils.o
	gcc ${CFLAGS} -o $@ $^
