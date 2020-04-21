boot_sect.bin: boot_sect.asm
	nasm boot_sect.asm -f bin -o boot_sect.bin
