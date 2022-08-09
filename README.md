# Raspberry Pi 3 Model B+ Operating System

_Hopefully, I can come up with a better name at some point._

I expect to base this operating system (OS) on the Exokernel (Engler et al.)
structure, with additional influences from Inferno (Pike, Ritchie, et al.) and
Liedtke's microkernel. I'm beginning its development in assembly.

## References

I've annotated the source with references to official documentation as follows:

* **BCM2835:** [_BCM2835 Arm Peripherals_](
  https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf) with [
  errata](https://elinux.org/BCM2835_datasheet_errata)
* **BCM2836:** [_BCM2836 Arm Peripherals_](
  https://datasheets.raspberrypi.com/bcm2836/bcm2836-peripherals.pdf)
* **Cortex-A53:** [_Arm Cortex-A53 MPCore Processor Technical Reference Manual_
  ](https://developer.arm.com/documentation/ddi0500/j/)
* **RPi:** [_Raspberry Pi Firmware Wiki_](
  https://github.com/raspberrypi/firmware/wiki)

Additionally, the [_ARM Cortex-A Series Programmer's Guide for ARMv8-A_](
https://developer.arm.com/documentation/den0024/a/) and [_Arm Architecture
Reference Manual for A-profile Architecture_](
https://developer.arm.com/documentation/ddi0487/ha/) are helpful.

## Sources

[bztsrc/raspi3-tutorial](https://github.com/bztsrc/raspi3-tutorial) shows how
to access various hardware resources on the Raspberry Pi.

In my junior-level OS course at Georgia Tech, taught in the spring of 2020 by
Prof. Taesoo Kim, we built an operating system for the Raspberry Pi 3 Model B+
in Rust. The course Website is located at
<https://tc.gts3.org/cs3210/2020/spring/>.
