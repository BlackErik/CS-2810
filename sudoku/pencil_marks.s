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
                ret

# clear_used(board, group, used)
clear_used:
                ret

# pencil_marks(board, table)
pencil_marks:
                ret
