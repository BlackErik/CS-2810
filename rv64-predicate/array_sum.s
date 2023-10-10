                .global array_sum
                .text

# int array_sum(int *array, int count)
array_sum:
		#a0 array*
		#a1 count

		#s0 sum
		#s1 i
		#s2 array
		#s3 count

		addi sp, sp, -48
		sd ra, 32(sp)
		sd s3, 24(sp) 
		sd s2, 16(sp)
		sd s1, 8(sp)
		sd s0, 0(sp)

		li s0, 0
		li s1, 0
		mv s2, a0
		mv s3, a1
2:		bge s1, s3, 1f
		ld a0, (s2)
		call predicate
		ld t0, (s2)
		addi s2, s2, 8
		addi s1, s1, 1
		beqz a0, 2b
		add s0, s0, t0
		j 2b
1:
		mv a0, s0
		ld ra, 32(sp)
		ld s3, 24(sp) 
		ld s2, 16(sp)
		ld s1, 8(sp)
		ld s0, 0(sp)
		addi sp, sp, 48

		ret
