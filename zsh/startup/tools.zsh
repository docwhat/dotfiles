
function tools-update
{
  local orig_dir=$(pwd -L)

  local vim_chksum="$(md5sum ~/.vimrc)"

  if [ ! -d ~/.oh-my-zsh-custom/plugins/zsh-syntax-highlighting ]; then
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh-custom/plugins/zsh-syntax-highlighting
  fi

  local dir
  for dir in ~/.oh-my-zsh ~/.oh-my-zsh-custom/ ~/.oh-my-zsh-custom/plugins/zsh-syntax-highlighting ~/.homedir/packages/*(N/); do
    cd "${dir}"
    echo
    echo "${fg[blue]}===> ${fg[green]}$( pwd -L )${reset_color}"
    if git diff-index --quiet HEAD; then
      git pull --rebase
    else
      echo "${fg[red]} * skipping -- checkout is dirty${reset_color}"
      git status -s -b
    fi
    git log '@{u}..'
  done

  "$HOME/.oh-my-zsh-custom/rc-scripts/link"

  cd "${orig_dir}"

  local new_vim_chksum="$(md5sum ~/.vimrc)"
  if [ "${vim_chksum}" != "${new_vim_chksum}" ]; then
    # Install any new vim plugins.
    vim -c ':PluginInstall' -c ':qa'
  fi

  echo "${fg[green]}You may wish to consider running 'rbenv-update-plugins' or 'update-gems'${reset_color}"
}

alias gitlog="echo -n '====> '; git rev-parse --abbrev-ref HEAD ; git log '@{u}..'"

# EOF
