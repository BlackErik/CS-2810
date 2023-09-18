                .global am_or_fm

                .text
am_or_fm:
		li t1, 535
		li t2, 1605
		li t3, 88
		li t4, 108

		blt a0, t1, 1f
		bgt a0, t2, 1f
		li a0, 1
		ret
1:
		blt a0, t3, 2f
		bgt a0, t4, 2f
		li a0, 2
		ret
2:
		li a0, 0
                ret
