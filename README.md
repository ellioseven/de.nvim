# de.nvim

NeoVim development environment.

## Installation

```bash
# install.
$ git clone git@github.com:ellioseven/de.nvim.git ~/.opt/de-web

# add binaries to path.
$ export $PATH=$HOME/.opt/de.nvim/bin:$PATH

# build image
# eg: de-build 501 501 
$ de-build <UID> <GID>
```

## Usage

```bash
$ cd <directory>
$ de
```

__NOTE:__ Config at `$HOME/.opt/de.nvim/config` is mounted into `de` container.

## Docs

See the [README](https://github.com/ellioseven/de.nvim/wiki/README)

