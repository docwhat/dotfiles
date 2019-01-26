" Better Whitespace -- whitespace trimming and highlighting
if !HasPlugin('vim-better-whitespace')
  finish
endif

nmap <silent> <Leader><space> :StripWhitespace<CR>

augroup PlugBetterWhitespace
  autocmd!
  autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl :EnableStripWhitespaceOnSave
augroup END
