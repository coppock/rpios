.section .text

.global _start

_start:	/* Stop application processors. [Cortex-A53 4.3.2] */
	mrs	x0, mpidr_el1
	and	x0, x0, 0xff
	cbnz	x0, 3f
	/* Set stack pointer. */
	adr	x0, _stack
	mov	sp, x0
	/* Print "Hello, world!". */
	bl	uart1_init
	mov	w0, '\r
	bl	uart1_send
	adr	x19, hello_world
1:	ldrb	w0, [x19], 1
	cbz	w0, 2f
	bl	uart1_send
	b	1b
	/* Echo characters back. */
2:	bl	uart1_recv
	bl	uart1_send
	b	2b
	/* Go to sleep. */
3:	wfe
	b	3b

hello_world:
.asciz "Hello, world!\r\n"
