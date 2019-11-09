" Better Whitespace -- whitespace trimming and highlighting
if !HasPlugin('vim-better-whitespace')
  finish
endif

let g:strip_whitespace_confirm=0
let g:strip_only_modified_lines=1

nmap <silent> <Leader><space> :StripWhitespace<CR>

augroup PlugBetterWhitespace
  autocmd!
  autocmd FileType ruby,php,json,c,cpp,js,java,vim,html,xml,xsl :EnableStripWhitespaceOnSave
augroup END
