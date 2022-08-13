.text

.global console_print

console_print:
	stp	x6, x7, [sp, -16]!
	stp	x4, x5, [sp, -16]!
	stp	x2, x3, [sp, -16]!
	stp	lr, x1, [sp, -16]!
	stp	x19, x20, [sp, -16]!
	mov	x19, x0
	add	x20, sp, 24
	ldrb	w0, [x19], 1
	cbz	w0, 4f
1:	cmp	w0, '%
	beq	5f
2:	bl	uart1_send
3:	ldrb	w0, [x19], 1
	cbnz	w0, 1b
4:	ldp	x19, x20, [sp], 16
	ldr	lr, [sp], 64
	ret
5:	ldrb	w0, [x19], 1
	cmp	w0, '%
	beq	2b
	cmp	w0, 'd
	bne	6f
	ldr	x0, [x20], 8
	bl	putd
	b	3b
6:	cmp	w0, 's
	bne	7f
	ldr	x0, [x20], 8
	bl	puts
	b	3b
7:	sub	w1, w0, '0
	lsl	w1, w1, 1
	ldr	x0, [x20], 8
	bl	putx
	b	3b

putd:
	stp	x19, lr, [sp, -16]!
	mov	x19, x0
	cmp	x19, 0
	bge	2f
	mov	x0, '-
	bl	uart1_send
	neg	x19, x19
2:	mov	x1, 10
	udiv	x0, x19, x1
	msub	x19, x0, x1, x19
	cbz	x0, 3f
	bl	putd
3:	add	x0, x19, '0
	bl	uart1_send
	ldp	x19, lr, [sp], 16
	ret

putx:
	cbz	x1, 4f
	stp	x19, lr, [sp, -16]!
	sub	x1, x1, 1
	mov	x2, 0x10
	mov	x19, x0
	udiv	x0, x0, x2
	msub	x19, x0, x2, x19
	bl	putx
	add	x0, x19, '0
	cmp	x0, '9
	ble	3f
	add	x0, x0, ('a - '9 - 1)
3:	bl	uart1_send
	ldp	x19, lr, [sp], 16
4:	ret

puts:
	stp	x19, lr, [sp, -16]!
	mov	x19, x0
1:	ldrb	w0, [x19], 1
	cbz	w0, 2f
	bl	uart1_send
	b	1b
2:	ldp	x19, lr, [sp], 16
	ret
