" EditorConfig -- Additional configuration
if !HasPlugin('vim-editorconfig')
  finish
endif

let g:editorconfig_blacklist = {
      \ 'filetype': ['git.*', 'fugitive', 'diff'],
      \ 'pattern': ['\.un~$']}
let g:editorconfig_root_chdir = 1
let g:editorconfig_verbose = 1
let g:editorconfig_local_vimrc = 0 " Never!

command! EditorConfigReload call editorconfig#load()
