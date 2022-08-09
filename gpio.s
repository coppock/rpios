.section .text

.global gpio_fsel

.include "io.s"

.set IO_OFFSET_GPIO, 0x00200000

gpio_fsel:
	/* [BCM2835 6.1] */
	mov	x2, 10
	udiv	x3, x0, x2
	mov	x4, IO_BASE
	add	x4, x4, IO_OFFSET_GPIO
	/* GPFSEL0 is the first register for this peripheral. */
	ldr	w5, [x4, x3, LSL 2]
	msub	x2, x3, x2, x0
	mov	x6, 3
	mul	x2, x2, x6
	mov	x6, 7
	lsl	x6, x6, x2
	bic	x5, x5, x6
	lsl	x2, x1, x2
	orr	w5, w5, w2
	str	w5, [x4, x3, LSL 2]
	ret
