# MDL style
# vim:set ft=ruby:

all

rule 'MD007', indent: 4
rule 'MD029', style: 'ordered'
rule 'MD035', style: '---'

exclude_rule 'first-header-h1'        # MD002
exclude_rule 'ul-style'               # MD004
exclude_rule 'line-length'            # MD013
exclude_rule 'header-style'           # MD029
exclude_rule 'list-marker-space'      # MD030
exclude_rule 'no-inline-html'         # MD033
exclude_rule 'fenced-code-language'   # MD040
exclude_rule 'first-line-h1'          # MD041

# EOF
