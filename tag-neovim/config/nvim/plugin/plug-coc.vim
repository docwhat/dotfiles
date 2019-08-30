" CoC -- Conquer of Completion
if ! HasPlugin('coc.nvim')
  finish
endif

" if hidden not set, TextEdit might fail.
set hidden

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB> pumvisible() ? "\<DOWN>"
      \ : (<SID>is_whitespace() ? "\<TAB>" : coc#refresh())
snoremap <silent><expr> <TAB> pumvisible() ? "\<DOWN>"
      \ : (<SID>is_whitespace() ? "\<TAB>" : coc#refresh())
inoremap <expr><S-TAB> pumvisible() ? "\<UP>" : "\<C-h>"
inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<DOWN>" : coc#refresh()
inoremap <silent><expr> <C-p>
      \ pumvisible() ? "\<UP>" : coc#refresh()

" Checks if the cursor is at the beginning of a line or
" it is after whitespace.
function! s:is_whitespace()
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~? '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion when something is selected.
" Coc only does snippet and additional edit on confirm.
function DocwhatLeximaCompleteOrNewline() abort
  if pumvisible()
    if empty(v:completed_item)
      " Something has been selected from the menu (pum). Accept
      " that item.
      return "\<C-y>"
    else
      " Nothing has been selected from the menu (pum). Close menu
      " and add literal CR.
      return "\<C-y>" . lexima#expand('<CR>', 'i')
    endif
  else
    " `<C-g>u` means break undo chain at current position.
    return "\<C-g>u" . lexima#expand('<CR>', 'i')
  endif
endfunction

if HasPlugin('lexima.vim')
  let g:lexima_no_default_rules = 1
  call lexima#set_default_rules()
  inoremap <expr> <CR> DocwhatLeximaCompleteOrNewline()
else
  " `<C-g>u` means break undo chain at current position.
  inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<C-g>u\<CR>"
endif

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" " Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype ==# 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

highlight link CocHighlightText CursorLine

let g:fishmouse = "quoteme"

augroup CocGroup
  autocmd!
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Show signature of current function.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Close preview when done with popup.
  autocmd CursorMovedI * if pumvisible() != 0 | silent! pclose | endif
  autocmd InsertLeave  * if pumvisible() != 0 | silent! pclose | endif
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

function! DocwhatCocInstallAll()
  let dir = coc#util#extension_root()
  let res = coc#util#init_extension_root(dir)
  if res == -1| return | endif
  call coc#util#open_terminal({
        \ 'cwd': dir,
        \ 'cmd': 'yarn install',
        \ 'keepfocus': 1
        \})
endfunction

if HasPlugin('colorscheme-gruvbox')
  highlight link CocErrorSign GruvboxRedSign
  highlight link CocWarningSign GruvboxYellowSign
  highlight link CocInfoSign GruvboxBlueSign
  highlight link CocHintSign GruvboxAquaSign
endif

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" **************************************
" JEST
" **************************************
" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>

" EOF
