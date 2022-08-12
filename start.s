.section .text

.global _start

_start:	/* Stop application processors. [Cortex-A53 4.3.2] */
	mrs	x0, mpidr_el1
	and	x0, x0, 0xff
	cbnz	x0, 3f
	/* Set stack pointer. */
	adr	x0, _stack
	mov	sp, x0

	bl	uart1_init
	/* Hello, Rando! */
	bl	rng_init
	bl	rng_read
	sxtw	x1, w0
	adr	x0, hello
	bl	console_printf
	/* Echo characters back. */
2:	bl	uart1_recv
	bl	uart1_send
	b	2b
	/* Go to sleep. */
3:	wfe
	b	3b

hello:	.asciz "Hello, %d!\r\n"
