# vim: ft=zsh :

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
  if [ -z "${JAVA_HOME}" ]; then
    unset JAVA_HOME
  fi
fi
