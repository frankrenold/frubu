#!/bin/bash

# Function to check if a package is installed
is_installed() {
  dpkg -s "$1" >/dev/null 2>&1
}

# Function to install packages if not already installed
install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    sudo apt -y install "${to_install[@]}"
  fi
}

# Function to check if snap is installed
is_snap_installed() {
    local snap_name="$1"

    # Check if snap command exists
    if ! command -v snap &> /dev/null; then
        echo "Error: snap command not found. Install snapd first." >&2
        return 2
    fi

    # Check if package is installed
    if snap list | grep -q "^$snap_name\s"; then
        return 0  # Success: package is installed
    else
        return 1  # Failure: package not installed
    fi
}

# Function to install snaps if not already installed
install_snaps() {
  local snaps=("$@")
  local to_install=()

  for snp in "${snaps[@]}"; do
    if ! is_snap_installed "$snp"; then
      to_install+=("$snp")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    sudo snap install "${to_install[@]}"
  fi
}

# Function to check if flatpak is installed
is_flatpak_installed() {
    local flatpak_name="$1"

    # Check if flatpak command exists
    if ! command -v flatpak &> /dev/null; then
        echo "Error: flatpak command not found. Install flatpak first." >&2
        return 2
    fi

    # Check if package is installed
    if flatpak list --app | grep -q "$flatpak_name\s"; then
        return 0  # Success: package is installed
    else
        return 1  # Failure: package not installed
    fi
}

# Function to install flatpaks if not already installed
install_flatpaks() {
    local flatpaks=("$@")
    local to_install=()

    for fpk in "${flatpaks[@]}"; do
        if ! is_flatpak_installed "$fpk"; then
            to_install+=("$fpk")
        fi
    done

    if [ ${#to_install[@]} -ne 0 ]; then
        echo "Installing: ${to_install[*]}"
        sudo flatpak install --assumeyes "${to_install[@]}"
    fi
}

# Function to stop all running processes by name
stop_all() {
  echo "Searching for running $1 processes ..."

  # Find all PIDs matching '$1' in command line
  pids=$(pgrep -f $1 | grep -v "^$$$")

  # Check if any processes were found
  if [ -z "$pids" ]; then
      echo "❗ No $1 processes found."
      return
  fi

  # Kill each process one by one
  for pid in $pids; do
      echo "Terminating process ID: $pid"
      kill -TERM "$pid" 2>/dev/null && echo "✓ Terminated successfully." || echo "✗ Failed to terminate (maybe already gone)."
  done

  echo "🛑 All $1 processes terminated."
}