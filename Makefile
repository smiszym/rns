CFLAGS += -Wall
CFLAGS += -g

.PHONY: all default clean

default: rns

all: rns_MichalSzymanski.tar.bz2

main.o: main.c rns.h unit_test.h
	gcc ${CFLAGS} -c -o $@ $<

unit_test.o: unit_test.c rns.h unit_test.h
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c rns.h unit_test.h
	gcc ${CFLAGS} -c -o $@ $<

rns_env.o: rns_env.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_add.o: rns_add.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_sub.o: rns_sub.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns_mul.o: rns_mul.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

add_int128.o: add_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

sub_int128.o: sub_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

cmp_int128.o: cmp_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

divide_int128_by_10.o: divide_int128_by_10.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

int128_mod_M.o: int128_mod_M.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

load_int128.o: load_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

is_int128_zero.o: is_int128_zero.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

copy_int128.o: copy_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

shl_int128.o: shl_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

read_int128.o: read_int128.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

int_to_rns.o: int_to_rns.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns: main.o unit_test.o rns_env.o rns_add.o rns_sub.o rns_mul.o add_int128.o sub_int128.o cmp_int128.o divide_int128_by_10.o int128_mod_M.o load_int128.o is_int128_zero.o copy_int128.o shl_int128.o read_int128.o int_to_rns.o utils.o
	gcc ${CFLAGS} -o $@ $^

rns_MichalSzymanski.tar.bz2: rns
	rm -rf rns_MichalSzymanski
	mkdir rns_MichalSzymanski
	cp -t rns_MichalSzymanski *.h *.c *.s *.py Makefile README
	tar cvjf rns_MichalSzymanski.tar.bz2 rns_MichalSzymanski
	rm -rf rns_MichalSzymanski

clean:
	rm -rf *.o rns __pycache__
