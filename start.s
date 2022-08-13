.text

.global _start

_start:	/* Set stack pointer. */
	adr	x0, _stack
	mov	sp, x0
	/* Initialize devices. */
	bl	uart1_init
	/* Dump ATAGS. */
	mov	x0, 0x100
	bl	atags_dump
	/* Echo characters back. */
1:	bl	uart1_recv
	bl	uart1_send
	b	1b
