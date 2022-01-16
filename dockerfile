# @url https://pastebin.com/XcJShCSb

FROM ubuntu:focal
ENV LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# install: neovim
RUN apt-get update && apt-get install -y \
    git \
    fish \
    curl \
    build-essential \
    cmake \
    pkg-config \
    unzip \
    automake \
    libtool \
    libtool-bin \
    gettext && \
  cd /srv && \
  git clone https://github.com/neovim/neovim && \
  cd neovim && \
  git checkout stable && \
  make && \
  make install && \
  cd / && \
  rm -rf /srv/neovim && \
  apt-get remove -y \
    build-essential \
    cmake \
    pkg-config \
    automake \
    libtool \
    libtool-bin \
    gettext && \
  apt-get -y autoremove

# configure: user
ARG USER_ID
ARG GROUP_ID
RUN addgroup --gid $GROUP_ID user && \
  adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user
ENV HOME /home/user

# install: node
ENV NODE_VER "16.13.2"
ENV NVM_DIR "$HOME/.nvm"
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
  . "$NVM_DIR/nvm.sh" && \
  nvm install "$NODE_VER" && \
  nvm use node && \
  npm install --global yarn
ENV PATH "$HOME/.nvm/versions/node/v$NODE_VER/bin:$PATH"

# install: plug.vim
USER root
ADD config/nvim /home/user/.config/nvim
RUN chown -R user:user $HOME/.config
USER user
WORKDIR "$HOME/.opt/plug.vim"
RUN curl -fLO https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
WORKDIR "$HOME"
RUN nvim --headless +PlugInstall +qall
RUN mkdir -p $HOME/.config/coc
RUN mkdir -p "$HOME/.config/coc/extensions"
WORKDIR "$HOME/.config/coc/extensions"
RUN if [ ! -f package.json ] ; then echo '{"dependencies": {}}' > package.json ; fi && \
  yarn add \
    coc-eslint \
    coc-prettier \
    coc-tsserver \
    coc-json \
      --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod

ADD config/fish /home/user/.config/fish
