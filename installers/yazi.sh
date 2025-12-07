#!/bin/bash

# install dependencies
sudo apt -y install ffmpeg 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

# Setup the latest stable Rust toolchain via rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update

# Clone the repository and build Yazi
git clone https://github.com/sxyazi/yazi.git
cd yazi
cargo build --release --locked

# Then, add yazi and ya to your $PATH
sudo mv target/release/yazi target/release/ya /usr/local/bin/

# cleanup
cd -
rm -rf yazi/
