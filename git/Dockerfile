FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    netcat-openbsd \
    ca-certificates \
    curl \
    nano \
 && rm -rf /var/lib/apt/lists/*

# Create git user
RUN useradd -m -s /bin/bash git

# SSH setup
RUN mkdir -p /home/git/.ssh \
 && chmod 700 /home/git/.ssh

COPY ssh_config /home/git/.ssh/config
COPY entrypoint.sh /entrypoint.sh

RUN chmod 600 /home/git/.ssh/config \
 && chown -R git:git /home/git/.ssh \
 && chmod +x /entrypoint.sh

WORKDIR /data
USER git

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
