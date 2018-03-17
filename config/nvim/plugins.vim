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

" Auto-pairing, including adding `end` to if statements.
Plug 'cohama/lexima.vim'

" Detect indentation
Plug 'tpope/vim-sleuth'

" Allow chording 'jk' as a replacement for ESC
Plug 'kana/vim-arpeggio'

" lets you align comments, equal signs, etc.
Plug 'godlygeek/tabular'

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
" Only for lines that have been changed.
Plug 'tweekmonster/wstrip.vim'

Plug 'metakirby5/codi.vim'
Plug 'justinmk/vim-dirvish'
Plug 'editorconfig/editorconfig-vim'

" Git & VCS support
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'
Plug 'tpope/vim-rhubarb'

" Comments
Plug 'scrooloose/nerdcommenter'

" Unite/Denite
Plug 'Shougo/denite.nvim', { 'do': function('DoRemotePluginsUpdate') }

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }

" Completion & Snippets
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemotePluginsUpdate') }
Plug 'docwhat/deoplete-better-length-matcher.nvim'
Plug 'Shougo/neco-vim'
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-go'
Plug 'Shougo/deoplete-rct'
Plug 'fishbullet/deoplete-ruby'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'eagletmt/neco-ghc'
Plug 'zchee/deoplete-jedi'
Plug 'tweekmonster/deoplete-clang2'
Plug 'ternjs/tern_for_vim', { 'do': 'npm upgrade' }
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-zsh'

" Neovim Development
Plug 'tweekmonster/nvimdev.nvim'
Plug 'tweekmonster/helpful.vim'

" Neoformat
Plug 'sbdchd/neoformat'

" Style/Lint
Plug 'dbakker/vim-lint'
Plug 'neomake/neomake'

" Markdown
Plug 'tpope/vim-markdown'

" NGinX
" Plug 'fatih/vim-nginx'
Plug 'chr4/nginx.vim'

" Jekyll/Liquid
Plug 'tpope/vim-liquid'

" Javascript & JSON
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/vim-jsx-improve'

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
Plug 'nanotech/jellybeans.vim'

" Terraform
Plug 'hashivim/vim-terraform'
Plug 'fatih/vim-hclfmt'

" Docker
Plug 'ekalinin/Dockerfile.vim'

" Sieve (RFC 5228)
Plug 'vim-scripts/sieve.vim'

call plug#end()

" vim: set foldminlines=0 foldmethod=marker :
