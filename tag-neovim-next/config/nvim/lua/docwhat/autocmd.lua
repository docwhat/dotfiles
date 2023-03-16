local function augroup(name) vim.api.nvim_create_augroup('docwhat_' .. name, { clear = true }) end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function() vim.highlight.on_yank() end,
})

-- " Create directories if the parent directory for a
-- " file doesn't exist.
-- " vimscript version from: http://stackoverflow.com/a/4294176/108857
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup('create_parent_dir_on_save'),
  pattern = '*',
  callback = function(args)
    local dir = vim.fn.fnamemodify(args.file, ':h')

    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir) end
  end,
})

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = augroup('put_help_on_the_right'),
  pattern = { '*.txt' },
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd('L') end
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup('last_cursor_location'),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup('resize_splits'),
  callback = function() vim.cmd('tabdo wincmd =') end,
})

-- Make quitting readonly buffers easier.
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if not vim.opt.modifiable:get() or vim.opt.readonly:get() then
      vim.keymap.set('n', 'q', vim.cmd.quit, { desc = '[Q]uit this buffer' })
    end
  end,
  group = augroup('readonly_keymaps'),
  pattern = '*',
})
