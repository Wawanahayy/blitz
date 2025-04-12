#!/bin/bash

curl -s https://raw.githubusercontent.com/Wawanahayy/JawaPride-all.sh/refs/heads/main/display.sh | bash

# Update dan upgrade sistem
echo "Updating and upgrading the system..."
apt-get update -y && apt-get upgrade -y

# Instalasi dependensi yang diperlukan
echo "Installing dependencies..."
apt-get install -y curl git build-essential libssl-dev pkg-config libudev-dev

# Instal Solana CLI
echo "Installing Solana CLI..."
curl -sSf https://release.solana.com/stable/install/solana-install-init.sh | sh
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Memverifikasi instalasi Solana CLI
if ! command -v solana &> /dev/null; then
    echo "Solana CLI tidak terpasang dengan benar!"
    exit 1
fi

# Instalasi Rust (jika belum terinstal)
echo "Installing Rust (Cargo)..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

# Cek apakah Cargo sudah terinstal
if ! command -v cargo &> /dev/null; then
    echo "Cargo (Rust) tidak terpasang dengan benar!"
    exit 1
fi

# Clone repositori Bitz Mining (jika belum ada)
echo "Cloning Bitz Mining CLI repository..."
git clone https://github.com/Wawanahayy/blitz.git /root/bitz_mining
cd /root/bitz_mining

# Instalasi Bitz Mining CLI
echo "Building Bitz Mining CLI..."
cargo build --release

# Memeriksa keberhasilan build
if [ ! -f "/root/bitz_mining/target/release/bitz" ]; then
    echo "Gagal membangun Bitz Mining CLI!"
    exit 1
fi

# Meminta seed phrase untuk Solana wallet
echo "Masukkan seed phrase Solana Anda:"
read -s SEED_PHRASE

# Menghasilkan keypair menggunakan seed phrase
echo "Menghasilkan keypair Solana..."
solana-keygen recover "prompt://?key=0/0" --outfile /root/.config/solana/id.json --phrase "$SEED_PHRASE"

# Memeriksa apakah Solana keypair telah berhasil dibuat
if [ ! -f "/root/.config/solana/id.json" ]; then
    echo "Gagal menghasilkan Solana keypair!"
    exit 1
fi

# Menyimpan informasi keypair ke file konfigurasi
echo "Solana keypair telah berhasil disimpan."

# Menjalankan Bitz Mining
echo "Memulai Bitz Mining..."
/root/bitz_mining/target/release/bitz collect

# Menunggu klaim hasil mining
echo "Mining berjalan... Gunakan 'bitz claim' untuk klaim hasil mining Anda."
