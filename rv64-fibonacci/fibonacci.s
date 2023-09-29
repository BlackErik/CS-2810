        		.global fibonacci
        		.text

fibonacci:
				# write your code here
			#a0 n
			#a1 a = 1
			#a2 b = 1
			#a3 i = 2
			#t1 temp
			
			li a1, 1 
			li a2, 1
			li a3, 2
	1:		add t1, a1, a2 
			mv a1, a2 
			mv a2, t1
			addi a3, a3, 1
			bge a3, a0, 2f
			j 1b 
	
	2:		mv a0, a2
			ret

