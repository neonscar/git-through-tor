#!/usr/bin/env sh
set -e

STACK_NAME="git-over-tor"
GIT_CONTAINER="git-tor"

usage() {
  echo "Usage: $0 {build|up|down|restart|shell|status|test-tor}"
  echo ""
  echo "Commands:"
  echo "  build     Build Docker images (no cache)"
  echo "  up        Start the docker compose stack"
  echo "  down      Stop the stack"
  echo "  restart   Rebuild and restart the stack"
  echo "  shell     Open a shell in the git container"
  echo "  status    Show stack status"
  echo "  test-tor  Test Tor connectivity from git container"
}

ensure_running() {
  if ! docker ps --format '{{.Names}}' | grep -q "^${GIT_CONTAINER}$"; then
    echo "[!] Stack not running. Starting it..."
    docker compose up -d
  fi
}

case "$1" in
  build)
    echo "[*] Building images (no cache)..."
    docker compose build --no-cache
    ;;
  up)
    echo "[*] Starting stack..."
    docker compose up -d
    ;;
  down)
    echo "[*] Stopping stack..."
    docker compose down
    ;;
  restart)
    echo "[*] Restarting stack..."
    docker compose down
    docker compose build --no-cache
    docker compose up -d
    ;;
  shell)
    ensure_running
    echo "[*] Opening shell in git container..."
    docker exec -it "$GIT_CONTAINER" bash
    ;;
  status)
    docker compose ps
    ;;
  test-tor)
    ensure_running
    echo "[*] Testing Tor connectivity..."
    docker exec "$GIT_CONTAINER" sh -c '
      set -e
      echo "[*] Querying Tor Project check API..."
      curl --silent --socks5-hostname tor:9050 https://check.torproject.org/api/ip \
        | sed "s/,/,\n/g"
    '
    ;;
  *)
    usage
    exit 1
    ;;
esac
