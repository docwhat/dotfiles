# There are different 'ls' versions out there. Let's make them act similar...
# shellcheck disable=SC2262,SC2263,SC2312

if command -v eza >/dev/null; then
  alias ls="eza"
  alias ll="eza --long -i --extended"
  alias tree="eza --tree"
elif command -v exa >/dev/null; then
  # EXA is deprecated and unmaintained.
  alias ls="exa --icons --time-style=iso --git --classify --color-scale --color=auto"
  alias ll="ls --long -i --extended"
  alias tree="ls --tree"
elif command -v gls >/dev/null && gls --version 2>&1 | grep -q 'coreutils'; then
  alias gls="gls --color=auto --classify=auto"
  alias ls="gls -C"
  alias ll="gls -al"
elif ls --color=auto >/dev/null 2>&1 && ls --classify=auto >/dev/null 2>&1; then
  alias gls="ls --color=auto --classify=auto"
  alias ls="gls -C"
  alias ll="gls -al"
else
  # Incase we're using BSD ls with color support.
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls="ls -CF"
  alias ls="ls -alF"
fi

# EOF
