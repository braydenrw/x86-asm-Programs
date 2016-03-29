SYMFORMAT=dwarf
FORMAT=elf

all: clearscrn gcd clean

gcd: gcd.o 
	gcc -m32 -nostartfiles -g -o gcd gcd.o

gcd.o: gcd.asm
	nasm -f $(FORMAT) -g -F $(SYMFORMAT) gcd.asm

clean:
	rm *.o

clobber: clean
	rm *.tar.gz stringgt

archive: 
	tar czvf gcd.tar.gz makefile gcd.asm

clearscrn:
	clear
