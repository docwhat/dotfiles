# Use the GNU make if available.
if [[ -d /usr/local/opt/make/libexec/gnubin ]]; then
  path=(/usr/local/opt/make/libexec/gnubin "${path[@]}")
  manpath=(/usr/local/opt/make/libexec/gnuman "${manpath[@]}")
fi
