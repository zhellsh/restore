#!/usr/bin/env bash
apt-prep() {
	sudo apt update
	sudo apt upgrade -y
	sudo apt install lz4 vim curl git python3-full -y
}
kernel_upgrade() {
	wget https://raw.githubusercontent.com/pimlie/ubuntu-mainline-kernel.sh/master/ubuntu-mainline-kernel.sh
	sudo install ubuntu-mainline-kernel.sh /usr/local/bin/
	sudo ubuntu-mainline-kernel.sh -i
}
dev_suite() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	curl https://nim-lang.org/choosenim/init.sh -sSf | sh
	sudo apt install nasm -y
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cd ~/
	mkdir -p dev/rust dev/nim dev/nasm
}
restore() {
	lz4 -d $1.tar.lz4
	tar xvf $1.tar -C oldhome/
}
apt-prep
kernel_upgrade
dev_suite
restore $1
reboot
