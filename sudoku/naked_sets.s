                .global naked_sets, single_pass, gather_set, clear_others
                .text

# gather_set(board, group, key) ->
#   set of pencil marks for cells identified by key
gather_set:

		# a0 board
		# a1 group
		# a2 key
		# a3 set
		# a4 index
		# a5 element
		# t2 (1<<index>
		
		li 	a3, 0
		li	a4, 0
		li	t0, 9

		j 	1f
3:		addi 	a4, a4, 1
1:		
		bge	a4, t0, 2f
		li	t1, 1
		sll	t2, t1, a4
		and	t3, a2, t2
		beqz	t3, 3b

		add 	t3, a1, a4  # group_element_address = group + group_index
                lb 	t2, (t3)     # board_index = lb( group_element_address )
                slli 	t3, t2, 1  # scaled_board_index = board_index << 1
                add 	t4, a0, t3  # board_element_address = board + scaled_board_index
                lh 	a5, (t4)     # element = lh( board_element_address )

		or	a3, a3, a5
		j	3b

2:		mv 	a0, a3
                ret

# clear_others(board, group, key, set) ->
#    0: nothing changed
#    1: something changed
clear_others:

		# a0	board
		# a1	group
		# a2	key
		# a3 	set
		# a4 	changed
		# a5    index
		# a6	element
		li	a4, 0 		# changed = 0
		not	a3, a3		# notset = ~set

		
		li 	a5, 0		# index = 0

		j 	1f
3:		addi 	a5, a5, 1

1:		li	t0, 9		
		bge	a5, t0, 2f	# if index >= 9, j2f
		li	t0, 1		# t0 = 1
		sll	t1, t0, a5	# (1<<index)
		and	a6, a2, t1	# key & (1<<index)
		bnez	a6, 3b
		add 	t3, a1, a5  # group_element_address = group + group_index
                lb 	t2, (t3)     # board_index = lb( group_element_address )
                slli 	t3, t2, 1  # scaled_board_index = board_index << 1
                add 	t4, a0, t3  # board_element_address = board + scaled_board_index
                lh 	a6, (t4)     # element = lh( board_element_address )
		
		and	a7, a6, a3
		beq	a6, a7, 3b
		sh	a7, (t4)
		li	a4, 1
		j	3b
		
2:		mv	a0, a4	
		ret

# single_pass(board, group) ->
#   0: nothing change
#   1: something changed
single_pass:
		# a0->s0 board
		# a1->s1 group
		# s2	key
		# s3	changed
		# s4	candidate set
		# s5	new set

		addi 	sp, sp, -56
		sd	ra, 48(sp)
		sd	s0, 40(sp)
		sd	s1, 32(sp)
		sd	s2, 24(sp)
		sd	s3, 16(sp)
		sd	s4, 8(sp)
		sd	s5, 0(sp)

		mv	s0, a0
		mv	s1, a1
		li	s2, 1
		li	s3, 0

1:		li 	t0, 510
		bge	s2, t0, 2f

		mv 	a0, s2
		call	count_bits
		mv	s4, a0

		mv	a0, s0
		mv	a1, s1
		mv	a2, s2
		call	gather_set
		mv	s5, a0
		call	count_bits
		
		bne	a0, s4, 3f
		mv	a0, s0
		mv	a1, s1
		mv	a2, s2
		mv	a3, s5

		call	clear_others		
		beqz	a0, 3f
		li	s3, 1
3:		addi	s2, s2, 1
		j 	1b
		

2:		mv	a0, s3
		ld	ra, 48(sp)
		ld	s0, 40(sp)
		ld	s1, 32(sp)
		ld	s2, 24(sp)
		ld	s3, 16(sp)
		ld	s4, 8(sp)
		ld	s5, 0(sp)
		addi 	sp, sp, 56

                ret

# naked_sets(board, table) ->
#   0: nothing changed
#   1: something changed
naked_sets:
                ret
