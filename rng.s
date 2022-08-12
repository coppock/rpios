.section .text

.global rng_init
.global rng_read

.include "io.s"

.set IO_OFFSET_RNG, 0x00104000

.set RNG_CTRL, 0*4
.set RNG_STAT, 1*4
.set RNG_DATA, 2*4

rng_init:
	mov	x0, IO_BASE
	add	x0, x0, IO_OFFSET_RNG
	mov	w1, 0x40000	/* Discard first, less random numbers. */
	str	w1, [x0, RNG_STAT]
	/* Eventually, I'll need to handle interrupts. */
	mov	w1, 1
	str	w1, [x0, RNG_CTRL]
	ret

rng_read:
	mov	x0, IO_BASE
	add	x0, x0, IO_OFFSET_RNG
1:	ldr	w1, [x0, RNG_STAT]
	lsr	w1, w1, 24
	cbz	w1, 1b
	ldr	w0, [x0, RNG_DATA]
	ret
