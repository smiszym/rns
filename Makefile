CFLAGS += -Wall
CFLAGS += -g

.PHONY: all default clean

default: rns

all: rns_MichalSzymanski.tar.bz2

HEADERS += rns.h
HEADERS += unit_test.h

RNS_LIB_OBJECTS += main.o
RNS_LIB_OBJECTS += unit_test.o
RNS_LIB_OBJECTS += rns_env.o
RNS_LIB_OBJECTS += rns_add.o
RNS_LIB_OBJECTS += rns_sub.o
RNS_LIB_OBJECTS += rns_mul.o
RNS_LIB_OBJECTS += int_to_rns.o
RNS_LIB_OBJECTS += rns_to_int.o
RNS_LIB_OBJECTS += utils.o

INT128_LIB_OBJECTS += add_int128.o
INT128_LIB_OBJECTS += sub_int128.o
INT128_LIB_OBJECTS += cmp_int128.o
INT128_LIB_OBJECTS += divide_int128_by_10.o
INT128_LIB_OBJECTS += int128_mod_M.o
INT128_LIB_OBJECTS += load_int128.o
INT128_LIB_OBJECTS += is_int128_zero.o
INT128_LIB_OBJECTS += copy_int128.o
INT128_LIB_OBJECTS += shl_int128.o
INT128_LIB_OBJECTS += read_int128.o

main.o: main.c ${HEADERS}
	gcc ${CFLAGS} -c -o $@ $<

unit_test.o: unit_test.c ${HEADERS}
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c ${HEADERS}
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

rns_to_int.o: rns_to_int.s rns.h
	gcc ${CFLAGS} -c -o $@ $<

rns: ${RNS_LIB_OBJECTS} ${INT128_LIB_OBJECTS}
	gcc ${CFLAGS} -o $@ $^

rns_MichalSzymanski.tar.bz2: rns
	rm -rf rns_MichalSzymanski
	mkdir rns_MichalSzymanski
	cp -t rns_MichalSzymanski *.h *.c *.s *.py Makefile README
	tar cvjf rns_MichalSzymanski.tar.bz2 rns_MichalSzymanski
	rm -rf rns_MichalSzymanski

clean:
	rm -rf *.o rns __pycache__
