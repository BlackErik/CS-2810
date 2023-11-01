                .global solve
                .equ    sys_exit, 93

                .data
naked_pre:      .asciz  "\nCalling naked_sets\n"
return_msg:     .asciz  "Return value is "
newline:        .asciz  "\n"
post_msg:       .asciz  "Board after naked_sets:\n\n"

                .text
# solve(board, table) -> 0
solve:
                # prelude
                addi    sp, sp, -16
                sw      ra, 12(sp)
                sw      s0, 8(sp)
                sw      s1, 4(sp)
                sw      s2, 0(sp)

                # s0: board
                # s1: table
                # s2: changed
                mv      s0, a0
                mv      s1, a1
                li      s2, 0

                # keep repeating until nothing changes
1:              la      a0, naked_pre
                call    puts

                # call naked_sets
                mv      a0, s0
                mv      a1, s1
                la      a4, naked_sets
                call    call_function
                mv      s2, a0
                la      a0, return_msg
                call    puts
                mv      a0, s2
                call    print_n
                la      a0, newline
                call    puts
                la      a0, post_msg
                call    puts
                mv      a0, s0
                call    print_board
                bnez    s2, 1b

                # return 0
                li      a0, 0

                # postlude
                lw      ra, 12(sp)
                lw      s0, 8(sp)
                lw      s1, 4(sp)
                lw      s2, 0(sp)
                addi    sp, sp, 16
                ret
