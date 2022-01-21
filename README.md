# de.nvim

NeoVim development environment.

## Installation

```bash
# install.
$ git clone git@github.com:ellioseven/de.nvim.git ~/.opt/de-web

# add binaries to path.
$ export $PATH=$HOME/.opt/de.nvim/bin:$PATH
```

## Usage

```bash
$ cd <directory>
$ de
```

## Development

```bash
# build image.
$ docker-compose build \
  --build-arg USER_ID=501 \
  --build-arg GROUP_ID=501
```

__NOTE:__ Config at `$HOME/.opt/de.nvim/config` is mounted into `de` container.

## Common Problems

- Problems installing packages? Remove `config/nvim/plugin/packer_compiled.lua`
