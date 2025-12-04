## One-Line-Installer for a fresh Ubuntu desktop installation

Run this command from your home directory.
```
curl -L https://github.com/frankrenold/frubu/archive/refs/heads/main.tar.gz | tar -xz && mv frubu-main frubu && cd frubu && find . -type f -name '*.sh' -exec chmod +x {} \; && ./run.sh
```

## Things to do manually to finish up

After the installation, reboot your system so everything starts properly setup the following things (still) manualy.

### Resilio Sync
- https://127.0.0.1:8888/
- Add the licence from Proton Pass
- Setup the Sync directories

Have fun with your fresh FRUBU installation.
