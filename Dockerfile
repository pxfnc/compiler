FROM --platform=arm64 debian:bullseye

RUN apt update \
  && apt install -y libnuma-dev git curl build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 zlib1g-dev pkg-config llvm \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

RUN adduser -sh /bin/bash elm

USER elm

ENV GHCUP_USE_XDG_DIRS=1

RUN export BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
  && export BOOTSTRAP_HASKELL_INSTALL_NO_STACK=1 \
  && export BOOTSTRAP_HASKELL_GHC_VERSION=9.0.2 \
  && export BOOTSTRAP_HASKELL_CABAL_VERSION=3.6.2.0 \
  && curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

ENV PATH=/home/elm/.local/bin:$PATH

WORKDIR /home/elm/compiler

VOLUME /home/elm/.cabal
