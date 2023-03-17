-- Description: Set options
-- luacheck: globals vim
local o = vim.opt

-- Enable auto write
o.autowrite = true

-- Show the line number
o.number = true

o.tabstop = 2
o.shiftwidth = 0
o.softtabstop = -1
o.expandtab = true
o.shiftround = true

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Hilight the line where the cursor The ISC License (ISC)
o.cursorline = true

-- Enable gui colors
o.termguicolors = true

-- Popup blend
o.pumblend = 10
-- Maximum number of entries in a popup
o.pumheight = 10
-- Make floating windows slightly transparent
o.winblend = 10

-- Define which helper symbols to show
-- eol:↴,
o.listchars = 'extends:…,precedes:…,nbsp:␣,tab:␉·'
-- Show some helper symbols
o.list = true

-- Enable syntax highlighing if it wasn't already (as it is time consuming)
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd([[syntax enable]]) end

-- Save undo history
o.undofile = true

-- Decrease update time
o.updatetime = 250
o.timeout = true
o.timeoutlen = 500

-- When scrolling, try not to get closer than this to the top and bottom.
o.scrolloff = 6

-- Always show the signcolumn, otherwise it would shift the text each time
o.signcolumn = 'yes'

-- Draw a bar to show where the 80 character column is.
o.colorcolumn = '80'

-- Command-line completion mode
o.wildmode = 'longest:full,full'

-- Horizontal splits will be below
o.splitbelow = true
-- Vertical splits will be to the right
o.splitright = true

-- Reduce command line messages
o.shortmess:append({ W = true, c = true })

if vim.fn.has('nvim-0.9') == 1 then
  -- Disable completion scanning messages
  o.shortmess:append({ C = true })
  -- Reduce scroll during window split
  o.splitkeep = 'screen'
end

o.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }

if vim.fn.has('nvim-0.7') == 1 then
  o.fillchars:append({
    vert = '║',
    horiz = '═',
    horizdown = '╦',
    horizup = '╩',
    verthoriz = '╬',
    vertleft = '╣',
    vertright = '╠',
  })
end
