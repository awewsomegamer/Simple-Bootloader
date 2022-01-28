wsl.exe nasm -f bin boot.asm -o boot.bin
wsl.exe nasm -f bin SecondStage.asm -o second.bin

COPY /b boot.bin+second.bin bootc.bin

qemu-system-x86_64 bootc.bin