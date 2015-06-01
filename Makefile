DEVICE = atmega328p
PROGRAMMER = usbtiny
PROGRAMMER_PORT = usb
F_CPU = 16000000
FUSE_L = 0b11011111
FUSE_H = 0b01011001
CC = avr-gcc
VUSB_DIR = ../vusb-20121206/usbdrv
CFLAGS = -Wall -O2 -mmcu=$(DEVICE) -DF_CPU=$(F_CPU)UL -I. -I$(VUSB_DIR)

.PHONY: avrdude-test
avrdude-test:
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -v

.PHONY: program
program: main.hex
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -U hfuse:w:$(FUSE_H):m -U lfuse:w:$(FUSE_L):m -U flash:w:main.hex:i

.PHONY: blink-hex
blink-hex: blink.elf
	avr-objcopy -j .text -j .data -O ihex blink.elf main.hex
	avr-size main.hex

.PHONY: usb-mouse-hex
usb-mouse-hex: usb-mouse.elf
	avr-objcopy -j .text -j .data -O ihex usb-mouse.elf main.hex
	avr-size main.hex

usb-mouse.elf: usb-mouse.o
	$(CC) -c $(CFLAGS) -o usbdrv.o $(VUSB_DIR)/usbdrv.c
	$(CC) -c $(CFLAGS) -o usbdrvasm.o $(VUSB_DIR)/usbdrvasm.S
	$(CC) -s $(CFLAGS) -o usb-mouse.elf usb-mouse.o usbdrv.o usbdrvasm.o

.PHONY: .clean
clean:
	$(RM) *.o *.elf main.hex

%.elf: %.o
	$(CC) -s $(CFLAGS) -o $@ $^
