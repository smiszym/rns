CFLAGS += -Wall
CFLAGS += -g

.PHONY: all clean

all: rns

main.o: main.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_env.o: rns_env.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_add.o: rns_add.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_sub.o: rns_sub.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_mul.o: rns_mul.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

read_int128.o: read_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

int_to_rns.o: int_to_rns.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns: main.o rns_env.o rns_add.o rns_sub.o rns_mul.o read_int128.o int_to_rns.o utils.o
	gcc ${CFLAGS} -o $@ $^

clean:
	rm -rf *.o rns __pycache__
