TOOLCHAIN = aarch64-elf

AS = ${TOOLCHAIN}-as
LD = ${TOOLCHAIN}-ld
OBJCOPY = ${TOOLCHAIN}-objcopy

OBJS = start.o console.o aux.o gpio.o rng.o

.s.o:
	${AS} ${AFLAGS} -o$@ $<

kernel8.img: ${OBJS}
	${LD} -Ttext=80000 -okernel8.elf ${OBJS}
	${OBJCOPY} -Obinary kernel8.elf $@

clean:
	rm -f kernel8.elf ${OBJS}
