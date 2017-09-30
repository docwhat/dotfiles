# Setup the LS stuff
if [[ -r ~/.config/personal/dircolors ]]; then
  if (( $+commands[gdircolors] )); then
    eval $(gdircolors --sh ~/.config/personal/dircolors)
  elif (( $+commands[dircolors] )); then
    eval $(dircolors  --sh ~/.config/personal/dircolors)
  fi
fi

if (( $+commands[gls] )); then
  alias ls="gls --color=auto -CF"
elif ls --color=auto >/dev/null 2>&1; then
  alias ls="ls --color=auto -CF"
else
  # Incase we're using BSD ls with color support.
  export CLICOLOR=1
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
  alias ls="ls -CF"
fi

# Fallback...
if [[ -z "${LS_COLORS}" ]]; then
  LS_COLORS='no=00'
  LS_COLORS+=':fi=00'
  LS_COLORS+=':di=33'
  LS_COLORS+=':pi=44;37;01'
  LS_COLORS+=':so=44;33;01'
  LS_COLORS+=':bd=44;36;01'
  LS_COLORS+=':cd=44;37'
  LS_COLORS+=':or=41;37;05;01'
  LS_COLORS+=':ex=01;32'
  LS_COLORS+=':do=01;05;35'
  LS_COLORS+=':*.cmd=01;32'
  LS_COLORS+=':*.exe=01;32'
  LS_COLORS+=':*.com=01;32'
  LS_COLORS+=':*.btm=01;32'
  LS_COLORS+=':*.bat=01;32'
  LS_COLORS+=':*.tar=01;31'
  LS_COLORS+=':*.tgz=01;31'
  LS_COLORS+=':*.tbz2=01;31'
  LS_COLORS+=':*.arj=01;31'
  LS_COLORS+=':*.taz=01;31'
  LS_COLORS+=':*.lzh=01;31'
  LS_COLORS+=':*.zip=01;31'
  LS_COLORS+=':*.z=01;31'
  LS_COLORS+=':*.Z=01;31'
  LS_COLORS+=':*.gz=01;31'
  LS_COLORS+=':*.bz2=01;31'
  LS_COLORS+=':*.rar=01;31'
  LS_COLORS+=':*.deb=01;31'
  LS_COLORS+=':*.i386.rpm=01;31'
  LS_COLORS+=':*.i486.rpm=01;31'
  LS_COLORS+=':*.i586.rpm=01;31'
  LS_COLORS+=':*.i686.rpm=01;31'
  LS_COLORS+=':*.src.rpm=00;31'
  LS_COLORS+=':*.png=01;35'
  LS_COLORS+=':*.jpeg=01;35'
  LS_COLORS+=':*.jpg=01;35'
  LS_COLORS+=':*.gif=01;35'
  LS_COLORS+=':*.bmp=01;35'
  LS_COLORS+=':*.ppm=01;35'
  LS_COLORS+=':*.tga=01;35'
  LS_COLORS+=':*.xbm=01;35'
  LS_COLORS+=':*.xpm=01;35'
  LS_COLORS+=':*.tif=01;35'
  LS_COLORS+=':*.xcf=01;35'
  LS_COLORS+=':*.au=00;36'
  LS_COLORS+=':*.wav=00;36'
  LS_COLORS+=':*.mp3=00;36'
  LS_COLORS+=':*.ogg=00;36'
  LS_COLORS+=':*.mov=01;37'
  LS_COLORS+=':*.mpg=01;37'
  LS_COLORS+=':*.mpeg=01;37'
  LS_COLORS+=':*.avi=01;37'
  LS_COLORS+=':*.fli=01;37'
  LS_COLORS+=':*.gl=01;37'
  LS_COLORS+=':*.dl=01;37'
  LS_COLORS+=':*.prc=00;32'
  LS_COLORS+=':*.pdb=00;32'
  export LS_COLORS
fi
