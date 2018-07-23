scriptencoding utf-8

call plug#begin(g:xdg_data_home . '/plugged')

" Usage: Plug 'blah', { 'do': function('DoRemotePluginsUpdate') }
function! DoRemotePluginsUpdate(arg)
  UpdateRemotePlugins
endfunction

" -- Utilities
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Support '.' correctly for plugins that support this module.
Plug 'tpope/vim-repeat'

" ds/cs/ys for deleting, changing, your surrounding chars (like ', ", etc.)
Plug 'tpope/vim-surround'

Plug 'tpope/vim-speeddating'

" Paired commands (using '[' and ']')
Plug 'tpope/vim-unimpaired'

" Auto-pairing, including adding `end` to if statements.
Plug 'cohama/lexima.vim'

" Detect indentation
Plug 'tpope/vim-sleuth'

" Allow chording 'jk' as a replacement for ESC
Plug 'kana/vim-arpeggio'

" lets you align comments, equal signs, etc.
Plug 'godlygeek/tabular'

" TOML
Plug 'cespare/vim-toml'

" Markdown syntax
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}

" Shows regions that were just yanked.
Plug 'machakann/vim-highlightedyank'

" Visualize the undo tree
Plug 'mbbill/undotree'

" Tags support; I recommend Universal Ctags
"   https://ctags.io/
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Convert single line things to multi-line and back
"   gS - single -> multi
"   gJ - multi -> single
Plug 'AndrewRadev/splitjoin.vim'

" Whitespace trimming and highlighting
Plug 'ntpeters/vim-better-whitespace'

Plug 'metakirby5/codi.vim'
Plug 'justinmk/vim-dirvish'
Plug 'sgur/vim-editorconfig'

" Git & VCS support
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-rhubarb'

" Comments
Plug 'scrooloose/nerdcommenter'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" TODO: Consider fzy instead? https://github.com/jhawthorn/fzy

" Neovim Development
Plug 'tweekmonster/nvimdev.nvim'
Plug 'tweekmonster/helpful.vim'
Plug 'syngan/vim-vimlint'
Plug 'ynkdir/vim-vimlparser'

" Style/Lint
Plug 'dbakker/vim-lint'
Plug 'w0rp/ale'


" Completion
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemotePluginsUpdate') }
" Plug 'docwhat/deoplete-better-length-matcher.nvim'

Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp' " ncm2 requires nvim-yarp

Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'wellle/tmux-complete.vim'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-cssomni'

Plug 'filipekiss/ncm2-look.vim' " Spelling completion
Plug 'ncm2/ncm2-match-highlight'


Plug 'jsfaint/ncm2-syntax' | Plug 'Shougo/neco-syntax'
Plug 'jsfaint/ncm2-vim' | Plug 'Shougo/neco-vim'
Plug 'jsfaint/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'

Plug 'ncm2/ncm2-html-subscope'
Plug 'ncm2/ncm2-markdown-subscope'

" Plug 'Shougo/neco-syntax'
" Plug 'zchee/deoplete-go'
" Plug 'Shougo/deoplete-rct'
" Plug 'fishbullet/deoplete-ruby'
" Plug 'eagletmt/neco-ghc'
" Plug 'zchee/deoplete-jedi'
" Plug 'tweekmonster/deoplete-clang2'
" Plug 'ternjs/tern_for_vim', { 'do': 'npm upgrade' }
" Plug 'wokalski/autocomplete-flow'
" Plug 'carlitux/deoplete-ternjs'
" Plug 'zchee/deoplete-zsh'

" Snippets
Plug 'ncm2/ncm2-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }

" NGinX
Plug 'chr4/nginx.vim'

" Jekyll/Liquid
Plug 'tpope/vim-liquid'

" Javascript & JSON
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/vim-jsx-improve'
Plug 'HerringtonDarkholme/yats.vim' " TypeScript Syntax

" XML, HTML & CSS
Plug 'othree/html5.vim'
" TODO: Use polyglot instead? It's a curated list of languages, syntaxes, and indentations.
" Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-ragtag'

" Show a facsimile of CSS colors as a highlight.
Plug 'chrisbra/color_highlight'

" Ruby
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug 'dougireton/vim-chef'
if exists('$RVM_PATH')
  Plug 'tpope/vim-rvm'
else
  Plug 'tpope/vim-rbenv'
endif

" BATS - Bash Automated Testing System
Plug 'docwhat/bats.vim'

" Groovy
Plug 'vim-scripts/groovyindent-unix'
Plug 'martinda/Jenkinsfile-vim-syntax'

" Go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'garyburd/go-explorer', { 'for': 'go', 'do': 'go get github.com/garyburd/go-explorer/src/getool' }

" Rust
Plug 'rust-lang/rust.vim'

" Lua
Plug 'tbastos/vim-lua'

" Display
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'nanotech/jellybeans.vim', { 'as': 'colorscheme-jellybeans' }
" Plug 'tomasr/molokai', { 'as': 'colorscheme-molokai' }
" Plug 'dracula/vim', { 'as': 'colorscheme-dracula' }
Plug 'morhetz/gruvbox', { 'as': 'colorscheme-gruvbox' }
Plug 'luochen1990/rainbow', { 'as': 'rainbow-parentheses' }

" Terraform
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-hclfmt'

" Docker
Plug 'ekalinin/Dockerfile.vim'

" Sieve (RFC 5228)
Plug 'vim-scripts/sieve.vim'

call plug#end()

" vim: set foldminlines=0 foldmethod=marker :
