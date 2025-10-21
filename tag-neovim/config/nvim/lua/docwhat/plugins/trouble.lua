-- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
-- https://github.com/folke/trouble.nvim#readme

local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-web-devicons" },
}

M.config = function()
  local map = vim.keymap.set

  map("n", "<leader>xx", function()
    require("trouble").toggle()
  end, { desc = "Toggle Trouble" })

  map("n", "<leader>xw", function()
    require("trouble").toggle("workspace_diagnostics")
  end, { desc = "Trouble [W]orkspace diagnostics" })

  map("n", "<leader>xd", function()
    require("trouble").toggle("document_diagnostics")
  end, { desc = "Trouble [D]ocument diagnostics" })

  map("n", "<leader>xq", function()
    require("trouble").toggle("quickfix")
  end, { desc = "Trouble [Q]uickfix" })

  map("n", "<leader>xl", function()
    require("trouble").toggle("loclist")
  end, { desc = "Trouble [L]oclist" })

  map("n", "<leader>xR", function()
    require("trouble").toggle("lsp_references")
  end, { desc = "Trouble LSP [R]eferences" })
end

return M
