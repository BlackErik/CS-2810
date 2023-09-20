                .global array_max
                .text

# int array_max(int *array, int count)
array_max:
	
	#a0 array
	#a1 count
	#t1 largest
	#a2 i
	#t2 current value
	
	li a2, 0

	ld t1, (a0)
1:	bge a2, a1, 2f
	ld t2, (a0)	
	ble t2, t1, 3f
	mv t1, t2
	j 1b

2:	mv a0, t1
	ret


3: 	addi a0,a0,8
	addi a2,a2,1
	j 1b
