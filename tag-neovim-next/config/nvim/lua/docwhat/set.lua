vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Save undo history
vim.opt.undofile = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- When scrolling, try not to get closer than this to the top and bottom.
vim.opt.scrolloff = 6

vim.opt.signcolumn = "yes"

-- Draw a bar to show where the 80 character column is.
vim.opt.colorcolumn = "80"

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
	vim.opt.shortmess:append({ C = true })
end
