                .global pencil_marks, get_used, clear_used, count_bits
                .text

# count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
count_bits:
		#a0 n
		#a1 i
		#a2 10
		#a3 count
		#t0 mask
		#t1 temp

		li a1, 0
		li a2, 10
		li a3, 0

1:		bge a1, a2, 3f
		li t0, 1
		sll t0, t0, a1
		and t1, a0, t0
		beqz t1, 2f
		addi a3, a3, 1

2:		addi a1, a1, 1
		j 1b

3:		mv a0, a3
                ret

# get_used(board, group) -> used
get_used:
		#a0->s0 board
		#a1->s1 group
		#s2 used
		#s3 group_index
		#s4 element

		addi sp, sp, -48
		sd ra, 40(sp)
		sd s0, 32(sp)
		sd s1, 24(sp)
		sd s2, 16(sp)
		sd s3, 8(sp)
		sd s4, 0(sp)

		mv s0, a0
		mv s1, a1
		li s2, 0
		li s3, 0

2:		li t1, 9
		bge s3, t1, 1f	# while i < 9
		add t3, s1, s3	# group_element_address = group + group_index
		lb t2, (t3)	# board_index = lb( group_element_address )
		slli t3, t2, 1	# scaled_board_index = board_index << 1
		add t4, s0, t3	# board_element_address = board + scaled_board_index
		lh s4, (t4)	# element = lh( board_element_address )
		mv a0, s4
		call count_bits # count = count_bits( element )

		addi s3, s3, 1	# i++

		li t0, 1
		bne a0, t0, 2b  # if count != 1, j 2b ^
		or s2, s2, s4	# used = used | element
		j 2b

1:		mv a0, s2
		ld ra, 40(sp)
		ld s0, 32(sp)
		ld s1, 24(sp)
		ld s2, 16(sp)
		ld s3, 8(sp)
		ld s4, 0(sp)
		addi sp, sp, 48

                ret

# clear_used(board, group, used)
clear_used:
                ret

# pencil_marks(board, table)
pencil_marks:
                ret
