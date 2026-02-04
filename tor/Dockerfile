FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    tor \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# Ensure correct ownership for Tor data
RUN chown -R debian-tor:debian-tor /var/lib/tor

COPY torrc /etc/tor/torrc

EXPOSE 9050

# Run Tor as the correct user
USER debian-tor

CMD ["tor"]
