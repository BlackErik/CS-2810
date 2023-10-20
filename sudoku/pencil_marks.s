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
		# a0->s0 board
		# a1->s1 group
		# a2->s2 !used
		# s3	changes_made
		# s4	board[board_index]
		# s5	element
		# s6	group_index

		addi 	sp, sp, -64
		sd 	ra, 56(sp)
		sd	s0, 48(sp)
		sd	s1, 40(sp)
		sd	s2, 32(sp)
		sd	s3, 24(sp)
		sd	s4, 16(sp)
		sd	s5, 8(sp)
		sd	s6, 0(sp)
		
		mv 	s0, a0
		mv	s1, a1
		not	s2, a2		#notused = ~used (flip the bits)
		li	s3, 0		#change_made = 0
		li	s6, 0		#group_index = 0

1:		li 	t0, 9
		bge	s6, t0, 2f	# if group_index >= 9, j 2f

		add 	t0, s1, s6	# group_element_address = group + group_index
		lb 	t1, (t0)	# board_index = lb( group_element_address )

		slli 	t3, t1, 1	# scaled_board_index = board_index << 1
		add 	s4, s0, t3	# board_element_address = board + scaled_board_index
		lh 	s5, (s4)	# element = lh( board_element_address )
		
		
		mv 	a0, s5		# move element to a0 parameter
		call 	count_bits	# count_bits( element )

		addi	s6, s6, 1	# group_index ++

		li 	t0, 1
		beq	a0, t0, 1b	# if count == 1, j 1b
		and	t1, s5, s2	# new_elt = elt & notused
		beq	t1, s5, 1b	# if new_elt == elt, j 1b
		
		
		sh	t1, (s4)	# board[board_index] = new_elt
		li	s3, 1		# change_made = 1

		j	1b

2:		mv 	a0, s3

		ld 	ra, 56(sp)
		ld	s0, 48(sp)
		ld	s1, 40(sp)
		ld	s2, 32(sp)
		ld	s3, 24(sp)
		ld	s4, 16(sp)
		ld	s5, 8(sp)
		ld	s6, 0(sp)
		addi 	sp, sp, 64

                ret

# pencil_marks(board, table)
pencil_marks:
		
		# a0->s0 board
		# a1->s1 table
		# s2	 changed
		# s3	 group_start
		# s4	 table+group_start?

		addi sp, sp, -48
		sd 	ra, 40(sp)
		sd 	s0, 32(sp)
		sd 	s1, 24(sp)
		sd 	s2, 16(sp)
		sd 	s3, 8(sp)
		sd 	s4, 0(sp)
		
		mv	s0, a0
		mv	s1, a1
		li	s2, 0 		# changed = 0
		li	s3, 0		# group_start = 0

1:		li	t0, 27*9  	# t0 = 27 * 9
		bge	s3, t0, 2f	# if group_start <= 27*9, j2f
		mv 	a0, s0		# loading board parameter
		add	s4, s1, s3	# s4= table + group_start
		mv	a1, s4		# loading table + group_start parameter
		call	get_used
		mv 	a2, a0		# moving used from get used to parameter 3
		mv	a0, s0		# loading board ( parameter 1 )
		mv	a1, s4		# loading table + group_start ( parameter 2 )
		call 	clear_used
		addi	s3, s3, 9	# increment our counter before any jumb backs
		beqz	a0, 1b		# if clear used returns 0, j1b
		li	s2, 1
		j	1b

2: 		mv	a0, s2
		ld 	ra, 40(sp)
		ld 	s0, 32(sp)
		ld 	s1, 24(sp)
		ld 	s2, 16(sp)
		ld 	s3, 8(sp)
		ld 	s4, 0(sp)
		addi 	sp, sp, 48

                ret
