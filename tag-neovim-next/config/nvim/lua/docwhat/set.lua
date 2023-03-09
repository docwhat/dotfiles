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

o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup

-- Save undo history
o.undofile = true

-- Decrease update time
o.updatetime = 250
o.timeout = true
o.timeoutlen = 500

-- When scrolling, try not to get closer than this to the top and bottom.
o.scrolloff = 6

-- Always show the signcolumn, otherwise it would shift the text each time
o.signcolumn = "yes"

-- Draw a bar to show where the 80 character column is.
o.colorcolumn = "80"

-- Command-line completion mode
o.wildmode = "longest:full,full"

o.shortmess:append({ W = true, I = true, c = true })

o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

if vim.fn.has("nvim-0.9.0") == 1 then
	o.splitkeep = "screen"
	o.shortmess:append({ C = true })
end
