                .global _start
                .equ    sys_exit, 93

                .data
newline:        .asciz  "\n"
intro_msg:      .asciz  "Testing get_used with the following board:\n\n"
test_row_msg:   .asciz  "\nTesting get_used on row "
test_col_msg:   .asciz  "\nTesting get_used on column "
test_box_msg:   .asciz  "\nTesting get_used on 3x3 box "
return_val_msg: .asciz  "Return value: "
the_set_msg_1:  .asciz  " (the set "
the_set_msg_2:  .asciz  ")\n"

                .text
_start:
				.option	push
				.option norelax
				la		gp, __global_pointer$
				.option pop

                # s0: board
                # s1: table
                # s2: i
                # s3: result value

                # reserve stack space for a board
                # 81*2 = 162 so reserve 176
                addi    sp, sp, -176
                mv      s0, sp

                # reserve stack space for the table
                # 27*9 = 243 so reserve 256
                addi    sp, sp, -256
                mv      s1, sp

                # read a board from stdin
1:              mv      a0, s0
                call    read_board
                bnez    a0, 1b

                # generate the lookup table
                mv      a0, s1
                call    make_group_table

                # start by printing the test board
                la      a0, intro_msg
                call    puts
                mv      a0, s0
                call    print_board

                # for i from [0, 27) step 11 mod 27
                li      s2, 0

                # 0-8 means a row
2:              li      t0, 9
                bge     s2, t0, 3f
                la      a0, test_row_msg
                call    puts
                mv      a0, s2
                call    print_n
                j       5f

3:              li      t0, 18
                bge     s2, t0, 4f
                la      a0, test_col_msg
                call    puts
                addi    a0, s2, -9
                call    print_n
                j       5f

4:              la      a0, test_box_msg
                call    puts
                addi    a0, s2, -18
                call    print_n

5:              la      a0, newline
                call    puts

                # make the call
                mv      a0, s0
                li      t0, 9
                mul     t1, s2, t0
                add     a1, s1, t1
                la      a4, get_used
                call    call_function
                mv      s3, a0

                la      a0, return_val_msg
                call    puts
                mv      a0, s3
                call    print_n
                la      a0, the_set_msg_1
                call    puts
                mv      a0, s3
                call    print_set
                la      a0, the_set_msg_2
                call    puts

                # next i
                addi    s2, s2, 11
                li      t0, 27
                rem     s2, s2, t0
                bnez    s2, 2b

                # clean up stack
                addi    sp, sp, 256
                addi    sp, sp, 176

                # exit
                li      a0, 0
                li      a7, sys_exit
                ecall
