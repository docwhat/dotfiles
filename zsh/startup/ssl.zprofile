# vim: set ft=zsh :

if [ -r /usr/local/etc/openssl/cert.pem ]; then
  # Override ChefDK, Vagrant, etc.'s CACert
  export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
elif [ -n "$SSL_CERT_FILE" -a ! -r "$SSL_CERT_FILE" ]; then
  unset SSL_CERT_FILE
fi
