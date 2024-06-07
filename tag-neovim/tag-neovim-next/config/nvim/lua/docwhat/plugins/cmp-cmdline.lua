-- nvim-cmp source for vim's cmdline.

local M = { "hrsh7th/cmp-cmdline" }
M.dependencies = { "nvim-cmp" }
M.keys = { ":", "/", "?" }

M.config = function()
  local cmp = require("cmp")

  -- normal Ex command
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "fuzzy_path" },
    }, {
      { name = "cmdline" },
    }),
  })

  -- forward and backward search command
  cmp.setup.cmdline({ "?", "/" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "treesitter" },
    },
  })
end

return M
