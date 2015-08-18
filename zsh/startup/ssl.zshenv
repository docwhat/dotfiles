# vim: set ft=zsh :

if [ -r /usr/local/etc/openssl/cert.pem ]; then
  # Override ChefDK, Vagrant, etc.'s CACert
  export SSL_CERT_FILE=/usr/local/etc/openssl/cert.pem
fi
