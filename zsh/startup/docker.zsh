# vim: ft=zsh :

## Ensure docker-compose doesn't get messed up by certificate settings.
alias docker-compose="env -u REQUESTS_CA_BUNDLE docker-compose"
