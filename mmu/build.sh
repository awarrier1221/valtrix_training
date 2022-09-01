IMG_NAME=ABC

set -o xtrace
set -e

mkdir -p build

riscv64-unknown-elf-g++ -x assembler-with-cpp -c -march=rv64imafdc -mcmodel=medany  -ggdb -o build/start.o mmu.s
riscv64-unknown-elf-g++ -x assembler-with-cpp -c -march=rv64imafdc -mcmodel=medany  -ggdb -o build/user.o user.s
riscv64-unknown-elf-g++ -c -march=rv64imafdc -mcmodel=medany -ggdb -o build/main.o mmu.cpp
riscv64-unknown-elf-g++ -o ${IMG_NAME}.elf -g -Xlinker -Map=output.map  -T linker.script -nostdlib build/start.o build/main.o build/user.o
riscv64-unknown-elf-objdump -xsD ${IMG_NAME}.elf > ${IMG_NAME}.dis

set +o xtrace
