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

3.  `rcup && rcup` — This second run picks up changes to the `~/.rcrc`
    file from the first run.

### Customizing your dotfiles

To make changes, customize, or override my files you can create
`~/.dotfiles-custom`.

To get started:

```sh
mkdir ~/.dotfiles-custom
cd ~/.dotfiles-custom
git init
```

_NOTE:_ If you're upgrading from an older version of my dotfiles, you
may need to update your `~/.rcrc` file. Ensure it has
`${HOME}/.dotfiles-custom` in the `DOTFILES_DIRS`. See
[`rcrc.example`](https://github.com/docwhat/dotfiles/blob/master/rcrc.example).

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

If you want to store secrets or personal info, you can use
`~/.dotfiles-personal` the same way as with `~/.dotfiles-custom`

You may or may not want to use `git` to store this and you shouldn't
upload it to a _public_ GitHub repository.

## Updating everything

Use the `tools-update` command. It offers suggestions of other commands
you can run.

```sh
$ tools-update --help
===================================================
Help
===================================================

Usage:tools-update [updater...]

  default      updates the dotfiles and runs 'rcup'
  all          alias for all the commands
  alfred       alfred configuration files
  brew         Manage brew via the ~/.Brewfile
  docker       docker completion files
  fonts        fonts for macOS
  gems         Ruby gems
  neovim       nvim plugins and plugin manager
  node-cli     Node CLI applications
  pip          python packages (2 & 3)
  rbenv        rbenv plugins
  terms        updates TERM entries for terminfo
  tmux         tmux plugin manager and plugins
  zplug        zplug and its plugins
  zsh

$ tools-update default tmux zplug zsh
===================================================
Updating dotfiles
===================================================

∓ Dotfiles
  Can't update /Users/docwhat/.dotfiles repository due to changes:
     M README.md
∓ Personal Dotfiles
  Already up to date.
  Current branch master is up to date.
λ7 ./broken-links:7     declare -ar broken=( )
λ7 ./broken-links:17    rm -vf

===================================================
Tmux
===================================================

∓ Tmux Package Manager
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-copycat
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-fpp
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-open
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-pain-control
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-prefix-highlight
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-sensible
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tmux-yank
  Already up to date.
  Current branch master is up to date.
∓ tmux plugin tpm
  Already up to date.
  Current branch master is up to date.

===================================================
Zplug
===================================================


z updating zplug
  [zplug] --self: unknown option

z updating plugins
  [zplug] Start to update 0 plugins in parallel


  [zplug] Elapsed time: 0.0196 sec.
   ==> Updating finished successfully!

===================================================
Zsh
===================================================

zcompile /Users/docwhat/.zshrc
zcompile /Users/docwhat/.zshenv
zcompile /Users/docwhat/.zprofile
zcompile /Users/docwhat/.zsh/startup/99ibm.zprofile
zcompile /Users/docwhat/.zsh/startup/default_user.zprofile
zcompile /Users/docwhat/.zsh/startup/github.zprofile
zcompile /Users/docwhat/.zsh/startup/homebrew.zprofile
zcompile /Users/docwhat/.zsh/startup/java.zprofile
zcompile /Users/docwhat/.zsh/startup/kube-solo.zprofile
zcompile /Users/docwhat/.zsh/startup/locale.zprofile
zcompile /Users/docwhat/.zsh/startup/macos.zprofile
zcompile /Users/docwhat/.zsh/startup/openstack.zprofile
zcompile /Users/docwhat/.zsh/startup/perl.zprofile
zcompile /Users/docwhat/.zsh/startup/personal.zprofile
zcompile /Users/docwhat/.zsh/startup/python.zprofile
zcompile /Users/docwhat/.zsh/startup/rust.zprofile
zcompile /Users/docwhat/.zsh/startup/ssh.zprofile
zcompile /Users/docwhat/.zsh/startup/zsh.zprofile
zcompile /Users/docwhat/.zsh/startup/000zsh.zshenv
zcompile /Users/docwhat/.zsh/startup/00comp.zshenv
zcompile /Users/docwhat/.zsh/startup/ack.zshenv
zcompile /Users/docwhat/.zsh/startup/asdf.zshenv
zcompile /Users/docwhat/.zsh/startup/bash.zshenv
zcompile /Users/docwhat/.zsh/startup/chef.zshenv
zcompile /Users/docwhat/.zsh/startup/docker.zshenv
zcompile /Users/docwhat/.zsh/startup/file.zshenv
zcompile /Users/docwhat/.zsh/startup/fzf.zshenv
zcompile /Users/docwhat/.zsh/startup/golang.zshenv
zcompile /Users/docwhat/.zsh/startup/haskell.zshenv
zcompile /Users/docwhat/.zsh/startup/homebrew.zshenv
zcompile /Users/docwhat/.zsh/startup/macos.zshenv
zcompile /Users/docwhat/.zsh/startup/make.zshenv
zcompile /Users/docwhat/.zsh/startup/node.zshenv
zcompile /Users/docwhat/.zsh/startup/pagers-editors.zshenv
zcompile /Users/docwhat/.zsh/startup/prompt.zshenv
zcompile /Users/docwhat/.zsh/startup/python.zshenv
zcompile /Users/docwhat/.zsh/startup/rust.zshenv
zcompile /Users/docwhat/.zsh/startup/snap.zshenv
zcompile /Users/docwhat/.zsh/startup/terminals.zshenv
zcompile /Users/docwhat/.zsh/startup/tmux.zshenv
zcompile /Users/docwhat/.zsh/startup/z-nodenv.zshenv
zcompile /Users/docwhat/.zsh/startup/z-rbenv.zshenv
zcompile /Users/docwhat/.zsh/startup/zsh.zshenv
zcompile /Users/docwhat/.zsh/startup/zz-last.zshenv
zcompile /Users/docwhat/.zsh/functions/_docker
zcompile /Users/docwhat/.zsh/functions/_docker-compose
zcompile /Users/docwhat/.zsh/functions/_docker-machine
zcompile /Users/docwhat/.zsh/functions/_gotmux
zcompile /Users/docwhat/.zsh/functions/_gulp
zcompile /Users/docwhat/.zsh/functions/_kind
zcompile /Users/docwhat/.zsh/functions/_kubectl
zcompile /Users/docwhat/.zsh/functions/_rustup
zcompile /Users/docwhat/.zsh/functions/_tmutil
zcompile /Users/docwhat/.zsh/functions/_tools-update
zcompile /Users/docwhat/.zsh/functions/colorize
zcompile /Users/docwhat/.zsh/functions/offset
zcompile /Users/docwhat/.zsh/functions/prompt_docwhat2_precmd
zcompile /Users/docwhat/.zsh/functions/prompt_docwhat2_ruby
zcompile /Users/docwhat/.zsh/functions/prompt_docwhat2_schars
zcompile /Users/docwhat/.zsh/functions/prompt_docwhat2_setup
zcompile /Users/docwhat/.zsh/functions/prompt_docwhat_setup
```
