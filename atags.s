.text

.global atags_dump

atags_dump:
	stp	x19, lr, [sp, -16]!
	mov	x19, x0
1:	ldp	w23, w24, [x19]
	and	w24, w24, 0xfff
	cbnz	w24, 2f
	adr	x0, atag_none
	b	6f
2:	cmp	w24, 1
	bne	3f
	adr	x0, atag_core
	b	6f
3:	cmp	w24, 2
	bne	4f
	ldp	w1, w2, [x19, 8]
	adr	x0, atag_mem
	b	6f
4:	cmp	w24, 9
	bne	5f
	add	x1, x19, 8
	adr	x0, atag_cmdline
	b	6f
5:	mov	w1, w24
	adr	x0, unrecognized_atag
6:	bl	console_print
	add	x19, x19, x23, LSL 2
	cbnz	w24, 1b
	ldp	x19, lr, [sp], 16
	ret

atag_none:
	.asciz "NONE\r\n"
atag_core:
	.asciz "CORE\r\n"
atag_mem:
	.asciz "MEM size 0x%4 start 0x%4\r\n"
atag_cmdline:
	.asciz "CMDLINE %s\r\n"
unrecognized_atag:
	.asciz "unrecognized 0x%4\r\n"
