#!/bin/bash

curl -s https://raw.githubusercontent.com/Wawanahayy/JawaPride-all.sh/refs/heads/main/display.sh | bash
# Update and Install dependencies
echo "Updating system and installing dependencies..."
sudo apt update -y && sudo apt upgrade -y
sudo apt install curl git build-essential -y

# Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Solana CLI
echo "Installing Solana CLI..."
curl --proto '=https' --tlsv1.2 -sSfL https://solana-install.solana.workers.dev | bash

# Adding Solana to PATH
echo "Adding Solana to PATH..."
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"

# Create a new Solana keypair (wallet)
echo "Creating Solana keypair..."
solana-keygen new --force -o ~/.config/solana/id.json

# Set the RPC to Eclipse mainnet
echo "Setting RPC to Eclipse mainnet..."
solana config set --url https://mainnetbeta-rpc.eclipse.xyz

# Install Bitz mining CLI using Cargo
echo "Installing Bitz mining CLI..."
cargo install bitz

# Check if all tools are installed correctly
echo "Verifying installations..."
solana --version
bitz --version
cargo --version

# Run Bitz collect to start the mining process
echo "Starting Bitz collection..."
bitz collect

# Final message
echo "All tools are installed and mining has started!"
echo "Use the following commands to manage your Bitz mining:"
echo "  bitz collect     # Collect Bitz tokens"
echo "  bitz claim       # Claim your collected Bitz"
echo "  bitz account     # Check your Bitz balance"
echo "  bitz -h or bitz --help  # See all available commands"

# Done
echo "Setup complete and mining started!"
