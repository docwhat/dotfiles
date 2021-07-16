-- This requires NeoVim 0.5 or newer.

require "docwhat.plugins"

vim.api.nvim_exec(
[[
set tabstop=2
set shiftwidth=0
set softtabstop=-1 " Use shiftwidth instead.
set expandtab
]],
false)
