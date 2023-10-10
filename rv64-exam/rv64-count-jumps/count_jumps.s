                .global count_jumps
                .text

# int count_jumps(int *array, int size)
count_jumps:

		# def count_jumps( array, size ):
		#	i = size -1
		#	count = 0
		#	while i < size:
		#		i = i + array[i]
		#		count +=1
		#	return count 
				
				

		# a0 array address
		# a1 size
		# a2 i
		# a3 count
		# t1 array[i]

		li t2, 1
		sub a2, a1, t2		# i = size - 1
		sub t4, a1, t2
		li a3, 0 		# count = 0
2:		slli t2, a2, 3
		add t2, a0, t2
		ld t3, (t2)
		add a2, a2, t3
		addi a3, a3, 1
		bge a2, a1, 1f		# if i >= size
		bltz a2, 1f		# if i <= 0 
		j 2b

1:		mv a0, a3
                ret
