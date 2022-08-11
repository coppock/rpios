.section .text

.global _start

_start:	mov	x19, x2
	/* Stop application processors. [Cortex-A53 4.3.2] */
	mrs	x0, mpidr_el1
	and	x0, x0, 0xff
	cbnz	x0, 3f
	/* Set stack pointer. */
	adr	x0, _stack
	mov	sp, x0
	/* Answer the Question. */
	bl	uart1_init
	adr	x0, answer
	mov	x1, 42
	bl	console_printf
	/* Where is the device tree? */
	adr	x0, tree
	mov	x1, x19
	bl	console_printf
	/* How much progress have we made? */
	adr	x0, progress
	bl	console_printf
	/* Echo characters back. */
2:	bl	uart1_recv
	bl	uart1_send
	b	2b
	/* Go to sleep. */
3:	wfe
	b	3b

answer:
.asciz "The answer is %d!\r\n"
tree:
.asciz "The device tree (if existent) is located at 0x%8.\r\n"
progress:
.asciz "We're 0.000000001%% finished with this OS.\r\n"
