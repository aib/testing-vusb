DEVICE = m328p
PROGRAMMER = buspirate
PROGRAMMER_PORT = 
F_CPU = 16000000
FUSE_L = 0b01101111
FUSE_H = 0b11011001
CC = avr-gcc
CFLAGS  = -Wall -mmcu=$(DEVICE) -DF_CPU=$(F_CPU)

.PHONY: avrdude-test
avrdude-test:
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -v

.PHONY: program
program: main.hex
	avrdude -p $(DEVICE) -c $(PROGRAMMER) -P $(PROGRAMMER_PORT) -U hfuse:w:$(FUSE_H):m -U lfuse:w:$(FUSE_L):m -U flash:w:main.hex:i

blink-hex: blink.o
	avr-objcopy -j .text -j .data -O ihex blink.o main.hex
	avr-size main.hex

clean:
	$(RM) *.o
