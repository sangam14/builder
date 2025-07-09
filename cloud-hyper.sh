# pre-requists 

export CLOUDH=$HOME/cloud-hypervisor
mkdir $CLOUDH
sudo apt-get update
sudo apt install git build-essential m4 bison flex uuid-dev qemu-utils musl-tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup target add x86_64-unknown-linux-mus
pushd $CLOUDH
git clone https://github.com/cloud-hypervisor/cloud-hypervisor.git
cd cloud-hypervisor
cargo build --release

sudo setcap cap_net_admin+ep ./target/release/cloud-hypervisor

cargo build --release --target=x86_64-unknown-linux-musl --all  

$CLOUDH/cloud-hypervisor/target/release/cloud-hypervisor

ln -sf "$CLOUDH/cloud-hypervisor/target/release/cloud-hypervisor" ./cloud-hypervisor

sudo apt update && sudo apt install -y mtools
ls -la /dev/kvm
groups $USER
sudo usermod -a -G kvm $USER

 wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img
 qemu-img convert -p -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw
  wget https://github.com/cloud-hypervisor/rust-hypervisor-firmware/releases/download/0.4.2/hypervisor-fw
 newgrp kvm
./scripts/create-cloud-init.sh
