DEVICE = atmega328p
PROGRAMMER = usbtiny
PROGRAMMER_PORT = usb
F_CPU = 16000000
FUSE_L = 0b11011111
FUSE_H = 0b01011001
CC = avr-gcc
VUSB_DIR = C:\Users\pc\aib\usb\vusb-20121206\usbdrv
CFLAGS = -Wall -mmcu=$(DEVICE) -DF_CPU=$(F_CPU) -I. -I$(VUSB_DIR)

.PHONY: avrdude-test
avrdude-test:
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -v

.PHONY: program
program: main.hex
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -U hfuse:w:$(FUSE_H):m -U lfuse:w:$(FUSE_L):m -U flash:w:main.hex:i

blink-hex: blink.o
	avr-objcopy -j .text -j .data -O ihex blink.o main.hex
	avr-size main.hex

usb-mouse: usb-mouse.o
	avr-objcopy -j .text -j .data -O ihex usb-mouse.o main.hex
	avr-size main.hex


clean:
	$(RM) *.o
