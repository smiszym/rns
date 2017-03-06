.PHONY: all

all: rns

main.o: main.c rns.h
	gcc -c -o $@ $<

utils.o: utils.c rns.h
	gcc -c -o $@ $<

rns.o: rns.s rns.h
	gcc -c -o $@ $<

rns: main.o rns.o utils.o
	gcc -o $@ $^
