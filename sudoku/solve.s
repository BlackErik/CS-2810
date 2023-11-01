                .global solve
                .equ    sys_exit, 93

                .data
msg_naked:      .asciz  "\nBoard after solving naked sets:\n"
msg_unsolvable: .asciz  "\nBoard is unsolvable\n"
msg_solved:     .asciz  "\nBoard is solved\n"
msg_most_const: .asciz  "\nMost constrained cell is at position ("
msg_most_mid:   .asciz  ", "
msg_most_end:   .asciz ")\n"

                .text
# solve(board, table) -> 0
solve:
                # prelude
                addi    sp, sp, -32
                sd      ra, 24(sp)
                sd      s0, 16(sp)
                sd      s1, 8(sp)
                sd      s2, 0(sp)

                # s0: board
                # s1: table
                mv      s0, a0
                mv      s1, a1

                # call naked_sets
1:              mv      a0, s0
                mv      a1, s1
                call    naked_sets
                bnez    a0, 1b

                # print the board
                la      a0, msg_naked
                call    puts
                mv      a0, s0
                call    print_board

                # call check_board
                mv      a0, s0
                la      a4, check_board
                call    call_function

                # save most-constrained cell in s2
                mv      s2, a0

                # bad board?
                bgez    a0, 2f
                la      a0, msg_unsolvable
                call    puts
                j       4f

                # solved?
2:              li      t0, 81
                blt     a0, t0, 3f
                la      a0, msg_solved
                call    puts
                j       4f

                # print position of most-constrained cell
3:              la      a0, msg_most_const
                call    puts
                li      t0, 9
                rem     a0, s2, t0
                call    print_n
                la      a0, msg_most_mid
                call    puts
                li      t0, 9
                div     a0, s2, t0
                call    print_n
                la      a0, msg_most_end
                call    puts

4:              li      a0, 0

                # postlude
                ld      ra, 24(sp)
                ld      s0, 16(sp)
                ld      s1, 8(sp)
                ld      s2, 0(sp)
                addi    sp, sp, 32
                ret
