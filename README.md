dotfiles
========

My personal dotfiles (e.g. `.bashrc`, `.zshrc`, etc.)

Feel free to use them as is and file pull requests or issues.

Alternatively, borrow what you want!

How to use
----------

1.  Install [rcm](https://github.com/thoughtbot/rcm)
2.  `git clone https://github.com/docwhat/dotfiles.git .dotfiles`
3.  `rcup`
4.  `rcup` -- This second run is needed to pick up changes to the `~/.rcrc` file.

### Adding a personal dotfile repo (for customizations or for private things like passwords, tokens, etc.):

1.  Clone/Create `~/.dotfiles-personal`
2.  Copy `~/.dotfiles/rcrc.example` to `~/.dotfiles-personal/rcrc` and edit it.
3.  Run `rcup` twice.
