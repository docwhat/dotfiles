# My dotfiles

This is my personal dotfiles (e.g. `.bashrc`, `.zshrc`, etc.)

Feel free to use them as is and file pull requests or issues.

And of course, borrow whatever you want!

## Installation

1.  Install [`rcm`](https://github.com/thoughtbot/rcm)
2.  Clone the `dotfiles` repository as `~/.dotfiles`:

    ```sh
    git clone https://github.com/docwhat/dotfiles.git .dotfiles
    ```

3.  `rcup && rcup` — This second run picks up changes to the `~/.rcrc` file from the first run.

### Customizing your dotfiles

To make changes, customize, or override my files you can create `~/.dotfiles-custom`.

To get started:

```sh
mkdir ~/.dotfiles-custom
cd ~/.dotfiles-custom
git init
```

_NOTE:_ If you're upgrading from an older version of my dotfiles, you may need to update your `~/.rcrc` file. Ensure it has `${HOME}/.dotfiles-custom` in the `DOTFILES_DIRS`. See [`rcrc.example`](https://github.com/docwhat/dotfiles/blob/master/rcrc.example).

To replace my files, use the same path in the repository.

A lot of config files support _local_ versions.

An incomplete list:

1.  NeoVim
    -   `config/nvim/local.vim`
2.  Vim
    -   `vimrc.local-pre` — sourced at the start of the `.vimrc`
    -   `vimrc.local` — sourced at the end of the `.vimrc`
3.  Git
    -   `config/git/local`

### Storing secrets

If you want to store secrets or personal info, you can use `~/.dotfiles-personal` the same way as with `~/.dotfiles-custom`

You may or may not want to use `git` to store this and you shouldn't upload it to a _public_ GitHub repository.

## Updating everything

Use the `tools-update` command. It offers suggestions of other commands you can run.

```sh
$ tools-update --help
===================================================
Help
===================================================

Usage:tools-update [updater...]

  default      updates the dotfiles and runs 'rcup'
  all          alias for all the commands
  alfred       alfred configuration files
  docker       docker completion files
  fonts        fonts for macOS
  gems         Ruby gems
  npm          Node.js packages
  pip          python packages (2 & 3)
  rbenv        rbenv plugins
  terms        updates TERM entries for terminfo
  tmux         tmux plugin manager and plugins
  yard         yard documentation for Ruby gems
  zgen         zgen and its plugins

$ tools-update default zgen terms tmux
===================================================
Updating dotfiles
===================================================

∓ Dotfiles
  Already up-to-date.
∓ Custom Dotfiles
  Already up-to-date.
∓ Personal Dotfiles
  Already up-to-date.

===================================================
Zgen
===================================================

∓ ZGen
  Already up-to-date.

z updating plugins
  -- zgen: Updating '/Users/docwhat/.zgen/RobSis/zsh-completion-generator-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/changyuheng/fz-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/chrissicool/zsh-256color-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/lukechilds/zsh-better-npm-completion-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/lukechilds/zsh-nvm-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/robbyrussell/oh-my-zsh-master' ...
  From github.com:robbyrussell/oh-my-zsh
     5667161..291e96d  master     -> origin/master
  Updating 5667161..291e96d
  Fast-forward
   themes/rkj-repos.zsh-theme | 6 +++---
   1 file changed, 3 insertions(+), 3 deletions(-)
  -- zgen: Updating '/Users/docwhat/.zgen/rupa/z-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/sharat87/pip-app-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/sorin-ionescu/prezto-master' ...
  From github.com:sorin-ionescu/prezto
     876f426..6975b11  master     -> origin/master
  Updating 876f426..6975b11
  Fast-forward
   modules/completion/init.zsh        | 15 ++++++++++++---
   modules/git/README.md              | 17 +++++++++++------
   modules/git/alias.zsh              | 26 ++++++++++++++++++--------
   modules/node/init.zsh              |  2 +-
   modules/prompt/functions/promptpwd |  4 ++++
   modules/python/init.zsh            | 27 ++++++++++++++++++++++++---
   modules/rsync/README.md            |  2 +-
   modules/tmux/README.md             |  4 ++++
   modules/tmux/init.zsh              |  2 +-
   runcoms/zpreztorc                  |  6 ++++++
   10 files changed, 82 insertions(+), 23 deletions(-)
  -- zgen: Updating '/Users/docwhat/.zgen/srijanshetty/docker-zsh-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/unixorn/git-extra-commands-master' ...
  From github.com:unixorn/git-extra-commands
     87cd2ab..4f10834  master     -> origin/master
  Updating 87cd2ab..4f10834
  Fast-forward
   bin/git-incoming | 30 +++++++++++++++---------------
   1 file changed, 15 insertions(+), 15 deletions(-)
  -- zgen: Updating '/Users/docwhat/.zgen/unixorn/rake-completion.zshplugin-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/zsh-users/zsh-autosuggestions-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/zsh-users/zsh-completions-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/zsh-users/zsh-history-substring-search-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/zsh-users/zsh-syntax-highlighting-0.5.0' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/zsh-users/zsh-syntax-highlighting-0.5.x' ...
  Already up-to-date.
  -- zgen: Deleting `/Users/docwhat/.zgen/init.zsh` ...
  -- zgen: Deleting `/Users/docwhat/.zsh/cache/zcompdump-lithium-5.3.1` ...
  27% cpu  7984 KiB  10.783 total
  0% cpu  1776 KiB  10.782 total

===================================================
Terms
===================================================

"terminfo.src", line 2361, terminal 'pccon+base': enter_bold_mode but no exit_attribute_mode
"terminfo.src", line 2361, terminal 'pccon+base': enter_reverse_mode but no exit_attribute_mode

===================================================
Tmux
===================================================

∓ Tmux Package Manager
  Already up-to-date.
∓ tmux plugin tmux-copycat
  Already up-to-date.
∓ tmux plugin tmux-fpp
  Already up-to-date.
∓ tmux plugin tmux-open
  Already up-to-date.
∓ tmux plugin tmux-pain-control
  Already up-to-date.
∓ tmux plugin tmux-prefix-highlight
  Already up-to-date.
∓ tmux plugin tmux-sensible
  Already up-to-date.
∓ tmux plugin tmux-yank
```
