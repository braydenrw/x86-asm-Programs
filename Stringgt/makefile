SYMFORMAT=dwarf
FORMAT=elf

all: clearscrn stringgt clean

stringgt: stringgt.o main.o 
	gcc -m32 -g -o stringgt stringgt.o main.o

stringgt.o: stringgt.asm
	nasm -f $(FORMAT) -g -F $(SYMFORMAT) stringgt.asm

main.o: main.c
	gcc -m32 -g -c -Wall -std=c99 -pedantic main.c

clean:
	rm *.o *~

clobber: clean
	rm *.tar.gz stringgt

archive: 
	tar czvf stringgt.tar.gz makefile stringgt.asm main.c

clearscrn:
	clear
