CFLAGS += -Wall
CFLAGS += -g

ASFLAGS += -g

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
INT128_LIB_OBJECTS += int128_to_dec.o
INT128_LIB_OBJECTS += load_int128.o
INT128_LIB_OBJECTS += is_int128_zero.o
INT128_LIB_OBJECTS += shl_int128.o
INT128_LIB_OBJECTS += read_int128.o

main.o: main.c ${HEADERS}
	gcc ${CFLAGS} -c -o $@ $<

unit_test.o: unit_test.c ${HEADERS}
	gcc ${CFLAGS} -c -o $@ $<

utils.o: utils.c ${HEADERS}
	gcc ${CFLAGS} -c -o $@ $<

%.o: %.s ${HEADERS}
	as ${ASFLAGS} -c -o $@ $<

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
