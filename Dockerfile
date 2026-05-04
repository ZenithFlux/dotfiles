# This Dockerfile creates my personalized dev environment
# Can be modified as needed for different host systems


# ─────────────────────────────────────────────
# Base Image
# ─────────────────────────────────────────────
FROM ubuntu:24.04

# ─────────────────────────────────────────────
# Build Arguments and Environment Variables
# ─────────────────────────────────────────────
ARG USER_NAME=chaitanya
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG LANG="en_IN.UTF-8"
ARG TERM="xterm-256color"

ARG UBUNTU_VERSION=2404
ARG CUDA_MAJOR_VERSION=13
ARG FZF_VERSION=0.72.0
ARG RIPGREP_VERSION=15.1.0
ARG NVM_VERSION=0.40.4
ARG NODE_VERSION=25.9.0
ARG TMUX_VERSION=3.6a
ARG NEOVIM_TAG=v0.12.2

ENV HOME="/home/${USER_NAME}"
ENV LANG="${LANG}"
ENV TERM="${TERM}"

# ─────────────────────────────────────────────
# Creating user
# ─────────────────────────────────────────────
RUN if [ "${USER_GID}" = "1000" ]; then \
        groupmod --new-name ${USER_NAME} ubuntu; \
    else \
        groupadd --gid ${USER_GID} ${USER_NAME}; \
    fi && \
    if [ "${USER_UID}" = "1000" ]; then \
        usermod --login ${USER_NAME} \
                --home ${HOME} \
                --move-home \
                --gid ${USER_GID} \
                ubuntu; \
    else \
        useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USER_NAME}; \
    fi && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/01_first_user

# ─────────────────────────────────────────────
# System Packages
# ─────────────────────────────────────────────
WORKDIR /tmp/installing_pkgs

RUN apt update && apt install -y \
    locales \
    build-essential \
    autoconf \
    automake \
    pkg-config \
    magic-wormhole \
    wget \
    git \
    sudo \
    libevent-dev \
    libncurses-dev \
    bison \
    cmake \
    ninja-build \
    gettext \
    curl \
    file \
    dpkg-dev \
    unzip \
    python3-venv && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen ${LANG}

# ─────────────────────────────────────────────
# CUDA + cuDNN Installation
# ─────────────────────────────────────────────
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VERSION}/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    apt update && \
    apt install -y cuda-toolkit cudnn9-cuda-${CUDA_MAJOR_VERSION} && \
    rm -rf /var/lib/apt/lists/*

# ─────────────────────────────────────────────
# fzf
# ─────────────────────────────────────────────
RUN curl -LO https://github.com/junegunn/fzf/releases/download/v${FZF_VERSION}/fzf-${FZF_VERSION}-linux_amd64.tar.gz && \
    tar xzf fzf-${FZF_VERSION}-linux_amd64.tar.gz && \
    install -m 755 fzf /usr/local/bin

# ─────────────────────────────────────────────
# ripgrep
# ─────────────────────────────────────────────
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}-1_amd64.deb && \
    dpkg -i ripgrep_${RIPGREP_VERSION}-1_amd64.deb

# ─────────────────────────────────────────────
# tmux Build & Install
# ─────────────────────────────────────────────
RUN wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz && \
    tar xvf tmux-${TMUX_VERSION}.tar.gz && \
    cd tmux-${TMUX_VERSION}/ && \
    ./configure && make && make install

# ─────────────────────────────────────────────
# Neovim Build & Install
# ─────────────────────────────────────────────
RUN git clone --depth 1 https://github.com/neovim/neovim.git -b ${NEOVIM_TAG} && \
    cd neovim && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    cd build && \
    cpack -G DEB && \
    dpkg -i nvim-linux-x86_64.deb

RUN mkdir -p /root/.config /root/.local/share && \
    ln -s ${HOME}/.config/nvim /root/.config && \
    ln -s ${HOME}/.local/share/nvim /root/.local/share

# ─────────────────────────────────────────────
# Switching to the non-root user
# ─────────────────────────────────────────────
WORKDIR ${HOME}
RUN rm -rf /tmp/* && \
    chown -R ${USER_NAME}:${USER_NAME} ${HOME}
USER ${USER_NAME}

# ─────────────────────────────────────────────
# NVM + NPM
# ─────────────────────────────────────────────
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV BASH_ENV="${HOME}/.bash_env"
RUN touch "${BASH_ENV}"
RUN echo -e '\n. "${BASH_ENV}"' >> ${HOME}/.bashrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | PROFILE="${BASH_ENV}" bash
RUN echo "${NODE_VERSION}" > .nvmrc && \
    nvm install

# ─────────────────────────────────────────────
# tmux Config & Dotfiles
# ─────────────────────────────────────────────
RUN git clone --depth 1 https://github.com/ZenithFlux/dotfiles.git -b server && \
    mkdir -p ~/.config && \
    ln -s ~/dotfiles/config/tmux/ ~/.config && \
    git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && \
    echo 'export PATH="/usr/local/cuda-13/bin:$HOME/.local/bin:$PATH"' >> ~/.bashrc && \
    ln -s ~/dotfiles/my.bashrc ~ && echo "source ~/my.bashrc" >> ~/.bashrc && \
    ln -s ~/dotfiles/my.inputrc ~ && echo '$include ~/my.inputrc' >> ~/.inputrc

# ─────────────────────────────────────────────
# Neovim Config
# ─────────────────────────────────────────────
RUN git clone --depth 1 https://github.com/ZenithFlux/nvim_config.git ~/.config/nvim

# ─────────────────────────────────────────────
# Entrypoint
# ─────────────────────────────────────────────
CMD ["bash"]
