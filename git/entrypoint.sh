#!/bin/sh
set -e

SSH_DIR="/home/git/.ssh"

# Ensure SSH dir exists with correct perms
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Import SSH keys
if [ -d /ssh ]; then
  cp /ssh/* "$SSH_DIR/" 2>/dev/null || true
  chmod 600 "$SSH_DIR"/id_* 2>/dev/null || true
  chmod 644 "$SSH_DIR"/*.pub 2>/dev/null || true
fi

# Fix permissions (important for non-root user)
chown -R git:git "$SSH_DIR"

# Add GitHub to known_hosts (to prevent first-time connection issues)
if ! ssh-keygen -F github.com > /dev/null 2>&1; then
  echo "[*] Adding GitHub to known_hosts..."
  mkdir -p /home/git/.ssh
  ssh-keyscan github.com >> /home/git/.ssh/known_hosts
  chown -R git:git /home/git/.ssh/known_hosts
fi

# Ensure ownership is correct for SSH config
chmod 600 /home/git/.ssh/config

# Tor availability check
if ! nc -z tor 9050; then
  echo "[!] Tor SOCKS proxy not reachable at tor:9050"
  exit 1
fi

exec "$@"
