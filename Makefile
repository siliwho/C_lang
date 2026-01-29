awb: main.c m.s
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tmain.ld m.s main.c -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin
assembly: main.c
	riscv64-unknown-elf-gcc -O0 -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tmain.ld main.c -S

binary: main.s main.ld
	riscv64-unknown-elf-gcc -O0 -ggdb -nostdlib -march=rv32i -mabi=ilp32 -Wl,-Tmain.ld m.s -o main.elf
	riscv64-unknown-elf-objcopy -O binary main.elf main.bin

printbin: main.bin
	xxd -e -c 4 -g 4 main.bin

startqemu: main.elf
	qemu-system-riscv32 -S -M virt -nographic -bios none -kernel main.elf -gdb tcp::1234

connectGDB: main.elf
	riscv64-elf-gdb main.elf -ex "target remote localhost:1234" -ex "break _start" -ex "continue" - q

clean:
	rm -rf *.bin *.elf
