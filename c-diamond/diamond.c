#include <stdio.h>
#include <stdio.h>
#include <stdio.h>

void print_diamond(int size)
{
	for (int i = 0; i < size; i++)
	{
		for (int j = 0; j < size - i - 1; j++)
		{
			printf(" ");
		}
		for (int k = 0; k < 2 * i + 1; k++)
		{
			printf("*");
		}
		printf("\n");
	}

	for (int i = size - 2; i >= 0; i--)
	{
		for (int j = 0; j < size - i - 1; j++)
		{
			printf(" ");
		}

		for (int k = 0; k < 2 * i + 1; k++)
		{
			printf("*");
		}
		printf("\n");
	}
}
