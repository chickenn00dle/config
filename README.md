# Dot Config

Config files for various tools I use daily. Feel free to leave feedback or suggest improvements by opening an issue!

## Installation

The following assumes you are running `zsh` on MacOS.

```
cd ~
git clone https://github.com/chickenn00dle/config.git .config
ln -s ~/.config/zsh/.zshenv ~/.zshenv
ln -s ~/.config/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.config/git/.gitconfig ~/.gitconfig
source ~/.config/zsh/.zshenv
source ~/.config/zsh/.zshrc
```

## Getting Started

### ZSH

Customizations can be added directly to `~/.config/zsh/.zshrc`. Alternatively, you can create a custom config file which must be named `~/.config/zsh/config.zsh` and make additions here.

### TMUX

You will first need to [install TMUX](https://github.com/tmux/tmux#installation). You can also install with [Homebrew](https://formulae.brew.sh/formula/tmux). Once installed, plugins will automatically be installed when Tmux is first opened. Customizations can be added directly to `~/.config/tmux/.tmux.conf`.

### NVIM

You will first need to [install NeoVim](https://neovim.io/). You can also install with [Homebrew](https://formulae.brew.sh/formula/neovim). Once installed, plugins will automatically be installed when NeoVim is first opened. Customizations can be added directly to `~/.config/nvim/init.vim`

### GIT

You will need to change the name and email values in `~/.config/git/.gitconfig`. You can refer to [the git docs](https://git-scm.com/docs/git-config) for adding customizations.

## Author

[Rasmy Nguyen](https://rzmy.win)


