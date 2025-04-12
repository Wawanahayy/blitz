#!/bin/bash

curl -s https://raw.githubusercontent.com/Wawanahayy/JawaPride-all.sh/refs/heads/main/display.sh | bash

# Update sistem dan install dependensi yang diperlukan
echo "Updating system and installing dependencies..."
apt update && apt upgrade -y
apt install -y curl git cargo build-essential

# Install Solana CLI
echo "Installing Solana CLI..."
curl -sSf https://raw.githubusercontent.com/solana-labs/solana/v2.1.19/install/solana-install-init.sh | sh

# Tambahkan Solana ke PATH
echo "export PATH=\"$HOME/.local/share/solana/install/active_release/bin:$PATH\"" >> ~/.bashrc
source ~/.bashrc

# Install Bitz Mining CLI
echo "Installing Bitz Mining CLI..."
cargo install --path .

# Menyediakan Direktori untuk Solana Keypair
mkdir -p ~/.config/solana
echo "Please enter your Solana wallet seed phrase:"
read -p "Seed Phrase: " SEED_PHRASE

# Menyimpan wallet keypair ke file
solana-keygen recover "prompt://?key=0/0" --outfile ~/.config/solana/id.json

# Verifikasi Wallet
echo "Verifying Solana wallet..."
solana balance

# Mulai mining dengan Bitz
echo "Starting Bitz mining..."
bitz collect

# Selesai
echo "Bitz mining has started. Use 'bitz claim' to claim your earnings after some time."
