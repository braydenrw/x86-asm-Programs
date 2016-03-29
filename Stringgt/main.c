//Brayden Roth-White
//CS 261
//April 21 2015

#include <stdio.h>
#include <stdlib.h>
#define WORD_LEN 32

int stringgt(char* a, char* b);

int main() {
	char word[WORD_LEN];
	char word2[WORD_LEN];
	int value = 0;

	printf("Enter a string: ");
	fgets(word, WORD_LEN, stdin);

	printf("Enter another string: ");
	fgets(word2, WORD_LEN, stdin);

	value = stringgt(word, word2);

	if(value == 0) {
		printf("False\n");
	} else {
		printf("True\n");
	}
}
