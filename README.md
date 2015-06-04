This repository is a record of me playing around with programming an Atmega on a breadboard and the V-USB software USB library.

## Warning
Some versions of Makefile in this repository are configured to disable the SPIEN fuse on your microcontroller, effectively bricking it unless you have a parallel programmer lying around. (Changing the fuse is supposed to be disabled during ICSP to prevent precisely this, but I somehow managed to do it anyway.)

### V-USB
The V-USB library is available at https://www.obdev.at/products/vusb/index.html
