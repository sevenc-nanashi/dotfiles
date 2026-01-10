FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    curl ca-certificates git build-essential pkg-config autoconf gawk \
    libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev

# Create user
RUN groupadd -r appuser && useradd -r -g appuser appuser
USER appuser
WORKDIR /home/appuser

COPY ./install.sh ./install.sh
COPY ./install.nu ./install.nu

ARG GITHUB_TOKEN
ENV MISE_GITHUB_TOKEN=${GITHUB_TOKEN}

ENTRYPOINT ["/bin/bash", "-c", "DOTFILES_INSTALLER_PATH=/home/appuser/install.nu bash ./install.sh"]
