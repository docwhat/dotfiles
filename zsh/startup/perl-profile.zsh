# This is for bootstrapping local::lib
# http://search.cpan.org/dist/local-lib/lib/local/lib.pm#The_bootstrapping_technique

# This was installed via:
# cpan App::cpanminus # (if cpanm isn't installed)
# cpanm local::lib
if [[ -f ~/perl5/lib/perl5/local/lib.pm ]]; then
  eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
fi

# EOF
