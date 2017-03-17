My dotfiles
===========

This is my personal dotfiles (e.g. `.bashrc`, `.zshrc`, etc.)

Feel free to use them as is and file pull requests or issues.

And of course, borrow whatever you want!

Installation
------------

1.  Install [rcm](https://github.com/thoughtbot/rcm)
2.  Clone the dotfiles repository as `~/.dotfiles`:

    ``` .sh
    git clone https://github.com/docwhat/dotfiles.git .dotfiles
    ```

3.  `rcup && rcup` -- This second run picks up changes to the `~/.rcrc` file from the first run.

### Adding a personal dotfile repository

You can add a personal dotfile repository that will override and extend my dotfile repository.

It's useful for customizations, email addresses, passwords and other "secrets".

1.  Clone/Create `~/.dotfiles-personal`
2.  Copy `~/.dotfiles/rcrc.example` to `~/.dotfiles-personal/rcrc` and edit it.
3.  Run `rcup` twice.

Updating everything
-------------------

Use the `tools-update` command. It offers suggestions of other commands you can run.

``` .sh
$ tools-update
 🔨 Updating dotfiles and tools🔧

∓ Dotfiles
  Can't update /Users/docwhat/.dotfiles repository due to changes.
     M README.md
∓ Personal Dotfiles
  Already up-to-date.
∓ Alfred Config
  Already up-to-date.
⇣ Docker ZSH completion
⇣ Docker-Compose ZSH completion
⇣ Docker-Machine ZSH completion
∓ Tmux Package Manager
  Already up-to-date.
∓ ZGen
  Already up-to-date.
  78% cpu  11336 KiB  7.265 total

z updating plugins
  -- zgen: Updating '/Users/docwhat/.zgen/RobSis/zsh-completion-generator-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/chrissicool/zsh-256color-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/robbyrussell/oh-my-zsh-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/sharat87/pip-app-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/sorin-ionescu/prezto-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/srijanshetty/docker-zsh-master' ...
  Already up-to-date.
  -- zgen: Updating '/Users/docwhat/.zgen/unixorn/git-extra-commands-master' ...
  Already up-to-date.
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
  Already up-to-date.
∓ tmux plugin tpm
  Already up-to-date.

You may wish to consider running:
  * rbenv-update-plugins
  * update-gems
  * update-pip
  * install-fonts
```
