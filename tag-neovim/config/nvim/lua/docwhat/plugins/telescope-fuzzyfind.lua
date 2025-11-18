-- luacheck: globals vim
local Plugin = {
  "nvim-telescope/telescope-fzf-native.nvim"
}

Plugin.dependencies = {
  "telescope.nvim"
}

-- Enable the plugin if 'make' is available.
if vim.fn.executable("make") == 1 then
  Plugin.enabled = true
  Plugin.build = "make"
  -- Fall back to CMake if 'make' is not available but 'cmake' is.
elseif vim.executable("cmake") == 1 then
  Plugin.enabled = true
  Plugin.build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install'
else
  Plugin.enabled = false
end

Plugin.config = function()
  require('telescope').setup {
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }

  require('telescope').load_extension("fzf")
end

return Plugin
