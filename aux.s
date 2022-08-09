.section .text

.global uart1_init
.global uart1_send
.global uart1_recv

.include "io.s"

.set IO_OFFSET_AUX, 0x00215000

.set AUX_IRQ, 0*4
.set AUX_ENABLES, 1*4

.set AUX_MU_IO_REG, 16*4
.set AUX_MU_IER_REG, 17*4
.set AUX_MU_IIR_REG, 18*4
.set AUX_MU_LCR_REG, 19*4
.set AUX_MU_MCR_REG, 20*4
.set AUX_MU_LSR_REG, 21*4
.set AUX_MU_MSR_REG, 22*4
.set AUX_MU_SCRATCH, 23*4
.set AUX_MU_CNTL_REG, 24*4
.set AUX_MU_STAT_REG, 25*4
.set AUX_MU_BAUD_REG, 26*4

uart1_init:
	str	lr, [sp, -16]!
	/*
	 * Select UART1 alternate function (5) for GPIO pins 14 and 15.
	 * [BCM2835 2.1.1, 6.2]
	 */
	mov	x0, 14
	mov	x1, 2 /* GPIO alternate function 5 is encoded as 0b010. */
	bl	gpio_fsel
	mov	x0, 15
	bl	gpio_fsel
	mov	x0, IO_BASE
	add	x0, x0, IO_OFFSET_AUX
	/* Enable the UART1 auxiliary device, the mini UART. [BCM2835 2.1.1] */
	ldr	w1, [x0, AUX_ENABLES]
	orr	w1, w1, 1
	str	w1, [x0, AUX_ENABLES]
	/* Set data size to eight bits. [BCM2835 2.2.2, with errata] */
	mov	w1, 3
	str	w1, [x0, AUX_MU_LCR_REG]
	/* Set baud rate to 9600. [BCM2835 2.2] */
	mov	w1, (250000000/8/9600 - 1)
	str	w1, [x0, AUX_MU_BAUD_REG]
	ldr	lr, [sp], 16
	ret

uart1_send:
	/* [BCM2835 2.2] */
	mov	x1, IO_BASE
	add	x1, x1, IO_OFFSET_AUX
1:	/* Poll transmit queue. */
	ldr	w2, [x1, AUX_MU_LSR_REG]
	tbz	w2, 5, 1b
	/* Write the byte to transmit. */
	str	w0, [x1, AUX_MU_IO_REG]
	ret

uart1_recv:
	/* [BCM2835 2.2] */
	mov	x1, IO_BASE
	add	x1, x1, IO_OFFSET_AUX
1:	/* Poll receive queue. */
	ldr	w2, [x1, AUX_MU_LSR_REG]
	tbz	w2, 0, 1b
	/* Read the received byte. */
	ldr	w0, [x1, AUX_MU_IO_REG]
	ret
