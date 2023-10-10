                .global stoi
                .text
stoi:
                # your code goes here
		# a0 array of strings
		# a1 = n = 0
		# a2 = i = 0 didn't end up using this
		# a3 c = string[i]

		# t1 '0'
		# t2 '9'
		# t3 10
		# t6 is negative?
		# a4 '-'

		# ascii 0=48 9=57

		li a1, 0
		li a2, 0

		li t1, 48
		li t2, 57
		li a4, 45

		lb a3, (a0)
		li t6, 0
		beq a3, a4, 3f
		

2:		lb a3, (a0)
		blt a3, t1, 4f
		bgt a3, t2, 4f

		li t3, 10
		
		mul t4, a1, t3
		sub t5, a3, t1
		add a1, t4, t5
		
		addi a0, a0, 1
		j 2b

3:		li t6, 1
		addi a0, a0, 1
		j 2b

4:		beqz t6, 1f
		neg a0, a1
		ret
		
		
1:		mv a0, a1
                ret
