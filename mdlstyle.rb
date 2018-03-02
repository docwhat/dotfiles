# MDL style
# vim:set ft=ruby:

all

rule 'MD007', indent: 4
rule 'MD029', style: 'ordered'
rule 'MD004', style: :dash
rule 'MD035', style: '---'

exclude_rule 'fenced-code-language' # MD040
exclude_rule 'first-line-h1'        # MD041
exclude_rule 'header-style'         # MD029
exclude_rule 'line-length'          # Line length
exclude_rule 'list-marker-space'    # Spaces after list markers
exclude_rule 'no-inline-html'       # MD033

# EOF
