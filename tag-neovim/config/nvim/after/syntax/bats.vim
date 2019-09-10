" Vim syntax file
" Language: Shell -- Extended for Bats (Bash Automated Testing System)
" Previous Author: Ross Timson <ross@rosstimson.com>

runtime syntax/sh.vim
syntax match batsTest              "\v\@test"
syntax keyword batsKeyword         run containedin=shExpr contained
syntax keyword batsKeyword         skip containedin=shExpr contained
syntax keyword batsKeyword         load

highlight default link batsTest            Identifier
highlight default link batsKeyword         Keyword
