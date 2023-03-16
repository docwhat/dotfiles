local function map(mode, shortcut, command, opts)
  if opts == nil then opts = {} end
  if not opts.remap == nil then opts.remap = true end
  if not opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, shortcut, command, opts)
end
local function nmap(shortcut, command, opts) map('n', shortcut, command, opts) end
local function vmap(shortcut, command, opts) map('v', shortcut, command, opts) end
local function xmap(shortcut, command, opts) map('x', shortcut, command, opts) end
local function cmap(shortcut, command, opts) map('c', shortcut, command, opts) end

-- [P]roject [V]iew
nmap('<leader>pv', vim.cmd.Ex)
nmap('-', vim.cmd.Explore)

-- Move selected lines up and down.
vmap('J', ":m '>+1<CR>gv=gv")
vmap('K', ":m '<-2<CR>gv=gv")

-- Prevent highlight being lost on (de)indent.
xmap('<', '<gv')
xmap('>', '>gv')

-- When [J]oining, don't change cursor position.
nmap('J', 'mzJ`z')

-- Have C-d and C-u keep the cursor in the center of the screen.
nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')

-- Have search forward and backwards keep the cursor in the center of the screen.
nmap('n', 'nzzzv')
nmap('N', 'Nzzzv')

-- Pastes over a visual/selected item without clobbering the
-- unnamed register.  Allows lots of multiple pastes in a row.
xmap('<leader>p', [["_dP]])

-- Copies to the PRIMARY selections.
map({ 'n', 'v' }, '<leader>y', [["+y]])
nmap('<leader>Y', [["+Y]])

-- Delete, sending it into the black-hole register.
map({ 'n', 'v' }, '<leader>d', [["_d]])

-- Format!
nmap('<leader>f', vim.lsp.buf.format)

nmap('<C-k>', '<cmd>cnext<CR>zz')
nmap('<C-j>', '<cmd>cprev<CR>zz')
nmap('<leader>k', '<cmd>lnext<CR>zz')
nmap('<leader>j', '<cmd>lprev<CR>zz')

-- Remap for dealing with word wrap
map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true, silent = true })
map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true, silent = true })

-- Diagnostic keymaps
nmap('[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
nmap(']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
nmap('<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
nmap('<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Expand %% into the directory on commands.
cmap('%%', "<c-r>=expand('%:h').'/'<cr>")

-- I use emacs bindings in command mode and shells.
cmap('<C-a>', '<home>')
cmap('<C-e>', '<end>')
cmap('<C-b>', '<left>')
cmap('<C-f>', '<right>')

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
nmap('<C-S>', '<Cmd>silent! update | redraw<CR>', { desc = 'Save' })
map({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

-- Toggle for common options.
nmap(
  'tb',
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  { desc = "Toggle 'background'" }
)
nmap('tc', '<Cmd>setlocal cursorline! cursorline?<CR>', { desc = "Toggle 'cursorline'" })
nmap('tC', '<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>', { desc = "Toggle 'cursorcolumn'" })
nmap(
  'th',
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = 'Toggle search highlight' }
)
nmap('ti', '<Cmd>setlocal ignorecase! ignorecase?<CR>', { desc = "Toggle 'ignorecase'" })
nmap('tl', '<Cmd>setlocal list! list?<CR>', { desc = "Toggle 'list'" })
nmap('tn', '<Cmd>setlocal number! number?<CR>', { desc = "Toggle 'number'" })
nmap('tr', '<Cmd>setlocal relativenumber! relativenumber?<CR>', { desc = "Toggle 'relativenumber'" })
nmap('ts', '<Cmd>setlocal spell! spell?<CR>', { desc = "Toggle 'spell'" })
nmap('tw', '<Cmd>setlocal wrap! wrap?<CR>', { desc = "Toggle 'wrap'" })
