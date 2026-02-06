#!/usr/bin/env sh
set -e

echo "[*] Setting up host directories for git-over-tor"

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Paths
REPO_DIR="$ROOT_DIR/repositories"
SSH_DIR="$ROOT_DIR/ssh"

# check repo dir
if [ ! -d "$REPO_DIR" ]; then
  echo "[+] Creating repositories directory"
  mkdir -p "$REPO_DIR"
else
  echo "[✓] repositories directory already exists"
fi

chmod 755 "$REPO_DIR"


# check ssh dir
if [ ! -d "$SSH_DIR" ]; then
  echo "[+] Creating ssh directory"
  mkdir -p "$SSH_DIR"
else
  echo "[✓] ssh directory already exists"
fi
chmod 700 "$SSH_DIR"


# check ssh keys
if [ ! -f "$SSH_DIR/id_ed25519" ]; then
  echo "[!] No SSH key found"
  echo "    Run:"
  echo "      ssh-keygen -t ed25519 -f $SSH_DIR/id_ed25519 -C \"git-over-tor\""
else
  echo "[✓] SSH private key exists"
  chmod 600 "$SSH_DIR/id_ed25519"
fi

if [ -f "$SSH_DIR/id_ed25519.pub" ]; then
  chmod 644 "$SSH_DIR/id_ed25519.pub"
fi


echo ""
echo "[✓] Host setup complete"
echo ""
echo "Directories:"
echo "  repositories/  → mounted at /data"
echo "  ssh/           → mounted at /ssh (read-only)"
echo ""
echo "Next steps:"
echo "  1) docker compose build --no-cache"
echo "  2) docker compose up -d"
echo "  3) docker exec -it git-tor bash"
