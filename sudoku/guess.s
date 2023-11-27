                .global guess

                .data
msg_guess_1:    .asciz  "\nGuessing "
msg_guess_2:    .asciz  " at position ("
msg_guess_3:    .asciz  ", "
msg_guess_4:    .asciz  ")\n"
                .text

# guess(board, table, position) ->
#     0 -> success
#     1 -> failure
guess:

		# a0 -> s0 board
		# a1 -> s1 table
		# a2 -> s2 position
		

		addi 	sp, sp, -48
		sd	ra, 48(sp)
		sd	s0, 40(sp)
		sd	s1, 32(sp)
		sd	s2, 24(sp)
		sd	s3, 16(sp)	
		sd	s4, 8(sp)	
		sd	s5, 0(sp)
		
		addi	sp, sp, -176
		mv	s0, a0
		mv	s1, a1
		mv	s2, a2
		
		li	t0, 0
1:		li	t1, 81
		bge	t0, t1, 2f
		slli	t2, t0, 1
		add	t3, s0, t2
		lh	t4, (t3)
		add	t3, sp, t2
		sh	t4, (t3)
		j	1b

2:		slli	a2, s2, 1
		add	a3, s0, a2
		lh	a0, (a3)

		li	s4, 1
3:		li	t1, 9
		bgt	s4, t1, 4f
		li	t2, 1
		sll	s3, t2, s4
		and	t3, s4, s3
		beqz	t3, 5f
		slli	a2, s2, 1
		add	a3, s0, a2
		sh	s3, (s0) 
		call	solve
		bnez	a0, 7f
		li	s5, 0	
		j	6f

4:		li	s5, 1	
		j	6f

5:		addi	s4, s4, 1
		j	3b

		li	t0, 0
7:		li	t1, 81
		bge	t0, t1, 3b
		slli	t2, t0, 1
		add	t3, sp, t2
		lh	t4, (t3)

		add	t3, s0, t2
		sh	t4, (t3)
		j	7b

6:		mv	a0, s5	
		addi	sp, sp, 176
		ld	ra, 48(sp)
		ld	s0, 40(sp)
		ld	s1, 32(sp)
		ld	s2, 24(sp)
		ld	s3, 16(sp)	
		ld	s4, 8(sp)	
		ld	s5, 0(sp)	
		addi 	sp, sp, 48
                ret
