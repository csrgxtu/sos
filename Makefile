all: os-image.bin

# run qemu to simulte booting of our code
run: all
	qemu-system-i386 -fda os-image.bin

# this is the actual disk image that the computer loads
# which is the combination of our compiled bootsector and kernel
os-image.bin: boot_sect.bin kernel.bin
	cat $^ > os-image.bin

# this builds the bin of our kernel from 2 objects
# - the kernel_entry, which jumps to main() in our kernel
# - the compiled c kernel
kernel.bin: kernel_entry.o kernel.o
	i686-elf-ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# build our kernel object file
kernel.o: kernel.c
	i686-elf-gcc -ffreestanding -c $< -o $@

# build our kernel_entry object file
kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

# assemble the boot sector to raw machine code
# - the -i options tell nasm where to find out useful assembly
# - routines that we include in boot_sect.asm
boot_sect.bin: boot_sect.asm
	nasm $< -f bin -I '.' -o $@

# clear away all generated files
clean:
	rm -rf *.bin *.dis *.o os-image.bin *.map

# disassemble our kernel - might be useful for debugging
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@