                .global check_board
                .text

# check_board(board) ->
#     -1: board is unsolvable
#     0-80: position of most-constrained cell
#     81: board is solved
check_board:

		# a0->s0 board
		# s1 	 i
		# s2 	 best_index = 81
		# s3	 best_count = 10

		addi	sp, sp, -48
		sd	ra, 32(sp)
		sd	s0, 24(sp)
		sd	s1, 16(sp)
		sd	s2, 8(sp)
		sd	s3, 0(sp)

		mv	s0, a0
		li	s1, 0
		li	s2, 81
		li	s3, 10

2:		li	t1, 81
		bge	s1, t1, 1f
		slli	t1, s1, 1	
		add	t0, t1, s0
		lh	a0, (t0)
		call	count_bits
		beqz	a0, 4f
		li 	t1, 1
		beq	a0, t1, 3f
		bge	a0, s3, 3f
		mv	s2, s1
		mv	s3, a0
3:		addi 	s1, s1, 1
		j	2b

4:		li	s2, -1

1:		mv	a0, s2
		ld	ra, 32(sp)
		ld	s0, 24(sp)
		ld	s1, 16(sp)
		ld	s2, 8(sp)
		ld	s3, 0(sp)
		addi	sp, sp, 48
                ret
