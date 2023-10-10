                .global array_sum
                .text

# int array_sum(int *array, int count, int threshold)
array_sum:
		#a0 array
		#a1 count
		#a2 threshold

		#t1 i
		#t2 sum
		#t3 current value


		li t1, 0
		li t2, 0 
		
3:		bge t1, a1, 1f
		ld t3, (a0)
		bge t3, a2, 2f
		addi a0, a0, 8
		addi t1, t1, 1
		j 3b

2:		add t2, t2, t3
		addi a0, a0, 8
		addi t1, t1, 1
		j 3b
		
1:		mv a0, t2
                ret
