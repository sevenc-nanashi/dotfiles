FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/.local/bin:${PATH}"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    ca-certificates \
    curl \
    file \
    git \
    procps \
    sudo \
    unzip \
    xz-utils \
  && rm -rf /var/lib/apt/lists/*

# Run the documented installer command.
RUN curl -fsSL https://github.com/sevenc-nanashi/dotfiles/raw/main/install.sh | bash

# Basic sanity checks that the installer did its work.
RUN test -x /root/.local/bin/mise \
  && test -L /root/.bashrc \
  && test -L /root/.config/nvim \
  && test -L /root/.config/starship.toml
