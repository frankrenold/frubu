## One-Line-Installer for a fresh Ubuntu desktop installation

Run this command from your home directory.

curl -L https://github.com/frankrenold/frubu/archive/refs/heads/main.tar.gz | tar -xz && mv frubu-main frubu && cd frubu && find . -type f -name '*.sh' -exec chmod +x {} \; && ./run.sh
