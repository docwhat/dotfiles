-- Description: Key mappings
-- luacheck: globals vim
local function map(mode, shortcut, command, opts)
  if opts == nil then
    opts = {}
  end
  if opts.remap ~= nil then
    opts.remap = true
  end
  if opts.silent ~= nil then
    opts.silent = true
  end
  vim.keymap.set(mode, shortcut, command, opts)
end
local function nmap(shortcut, command, opts)
  map("n", shortcut, command, opts)
end
local function vmap(shortcut, command, opts)
  map("v", shortcut, command, opts)
end
local function xmap(shortcut, command, opts)
  map("x", shortcut, command, opts)
end
local function cmap(shortcut, command, opts)
  map("c", shortcut, command, opts)
end
local function imap(shortcut, command, opts)
  map("i", shortcut, command, opts)
end

-- [P]roject [V]iew
nmap("<leader>pv", vim.cmd.Explore, { desc = "[P]roject [V]iew (netrw)" })
nmap("-", vim.cmd.Explore, { desc = "Project View (netrw)" })

-- Add undo break-points
imap(",", ",<c-g>u", { desc = "Add undo break-point" })
imap(".", ".<c-g>u", { desc = "Add undo break-point" })
imap(";", ";<c-g>u", { desc = "Add undo break-point" })

-- Move selected lines up and down.
vmap("J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vmap("K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Prevent highlight being lost on (de)indent.
xmap("<", "<gv", { desc = "Unindent selected lines" })
xmap(">", ">gv", { desc = "Indent selected lines" })

-- When [J]oining, don't change cursor position.
nmap("J", "mzJ`z", { desc = "Join lines" })

-- Have C-d and C-u keep the cursor in the center of the screen.
nmap("<C-d>", "<C-d>zz", { desc = "Scroll down" })
nmap("<C-u>", "<C-u>zz", { desc = "Scroll up" })

-- Have search forward and backwards keep the cursor in the center of the screen.
nmap("n", "nzzzv", { desc = "Search forward" })
nmap("N", "Nzzzv", { desc = "Search backward" })

-- Pastes over a visual/selected item without clobbering the
-- unnamed register.  Allows lots of multiple pastes in a row.
xmap("<leader>p", [["_dP]], { desc = "Paste over visual selection" })

-- Copies to the PRIMARY selections.
map(
  { "n", "v" },
  "<leader>y",
  [["+y]],
  { desc = "[Y]ank to PRIMARY selection" }
)
nmap("<leader>Y", [["+Y]], { desc = "[Y]ank line to PRIMARY selection" })

-- Delete, sending it into the black-hole register.
map(
  { "n", "v" },
  "<leader>d",
  [["_d]],
  { desc = "[D]elete into black-hole register" }
)

-- Format!
nmap("<leader>f", vim.lsp.buf.format, { desc = "[F]ormat entire buffer" })

nmap("<C-k>", "<cmd>cnext<CR>zz", { desc = "Go to next quickfix item" })
nmap("<C-j>", "<cmd>cprev<CR>zz", { desc = "Go to previous quickfix item" })
nmap("<leader>k", "<cmd>lnext<CR>zz", { desc = "Go to next location item" })
nmap("<leader>j", "<cmd>lprev<CR>zz", { desc = "Go to previous location item" })

-- Remap for dealing with word wrap
map(
  { "n", "x" },
  "k",
  [[v:count == 0 ? 'gk' : 'k']],
  { expr = true, silent = true }
)
map(
  { "n", "x" },
  "j",
  [[v:count == 0 ? 'gj' : 'j']],
  { expr = true, silent = true }
)

-- Diagnostic keymaps
nmap(
  "[d",
  vim.diagnostic.goto_prev,
  { desc = "Go to previous diagnostic message" }
)
nmap("]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
nmap(
  "<leader>e",
  vim.diagnostic.open_float,
  { desc = "Open floating diagnostic message" }
)
nmap("<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Expand %% into the directory on commands.
cmap(
  "%%",
  "<c-r>=expand('%:h').'/'<cr>",
  { desc = "Expand % to the current directory" }
)

-- I use emacs bindings in command mode and shells.
cmap("<C-a>", "<home>", { desc = "Go to beginning of line" })
cmap("<C-e>", "<end>", { desc = "Go to end of line" })
cmap("<C-b>", "<left>", { desc = "Go to previous character" })
cmap("<C-f>", "<right>", { desc = "Go to next character" })

-- Alternative way to save and exit in Normal mode.
-- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
nmap("<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "[S]ave" })
map(
  { "i", "x" },
  "<C-S>",
  "<Esc><Cmd>silent! update | redraw<CR>",
  { desc = "[S]ave and go to Normal mode" }
)

-- Toggle for common options.
nmap(
  "tb",
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  { desc = "[T]oggle '[b]ackground' (dark/light)" }
)
nmap(
  "tc",
  "<Cmd>setlocal cursorline! cursorline?<CR>",
  { desc = "[T]oggle '[c]ursorline'" }
)
nmap(
  "tC",
  "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>",
  { desc = "[T]oggle '[c]ursorcolumn'" }
)
nmap(
  "th",
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = "[T]oggle search [h]ighlight" }
)
nmap(
  "ti",
  "<Cmd>setlocal ignorecase! ignorecase?<CR>",
  { desc = "[T]oggle '[i]gnorecase'" }
)
nmap("tl", "<Cmd>setlocal list! list?<CR>", { desc = "[T]oggle '[l]ist'" })
nmap(
  "tn",
  "<Cmd>setlocal number! number?<CR>",
  { desc = "[T]oggle '[n]umber'" }
)
nmap(
  "tr",
  "<Cmd>setlocal relativenumber! relativenumber?<CR>",
  { desc = "[T]oggle '[r]elativenumber'" }
)
nmap("ts", "<Cmd>setlocal spell! spell?<CR>", { desc = "[T]oggle '[s]pell'" })
nmap("tw", "<Cmd>setlocal wrap! wrap?<CR>", { desc = "[T]oggle '[w]rap'" })
