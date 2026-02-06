# Git over  Tor
How to use Git over Tor with Docker.

## Requirements
You need a Docker intallation with Docker Compose.

## How to use

*host-setup.sh* checks if the folders you need are complete. And if for example ssh keys are missing how you create them.

*use.sh* can build, access and stop the Docker Container.

```bash
use.sh -h

Commands:
  build     Build Docker images (no cache)
  up        Start the docker compose stack
  down      Stop the stack
  restart   Rebuild and restart the stack
  shell     Open a shell in the git container
  status    Show stack status
  test-tor  Test Tor connectivity from git container
```

To access your Git Repo start the container stack (use.sh up), then connect to the container (use.sh shell). You land in the root directory for your repositories. Now clone or create a repo and use it.