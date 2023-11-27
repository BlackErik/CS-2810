#include "difference_of_squares.h"

unsigned int sum_of_squares( unsigned int number ){
	unsigned int sum = 0;
	for( unsigned int i = 0; i <= number; i++ ){
		sum+= i * i;
	}
	return sum;
}

unsigned int square_of_sum( unsigned int number ){
	unsigned int square = 0;
	for( unsigned int i = 0; i<= number; i++ ){
		square+= i ;
	}
	square = square * square;
	return square;
}

unsigned int difference_of_squares( unsigned int number ){
	unsigned int sum, square;
	sum = sum_of_squares( number );
	square = square_of_sum( number );
	return square - sum;
}
