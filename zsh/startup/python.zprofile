## This setups the command line python tricks
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

## This gets 'requests' to use the SSL cert bundle
if [ -r /usr/local/etc/openssl/cert.pem ]; then
  export REQUESTS_CA_BUNDLE=/usr/local/etc/openssl/cert.pem
fi
