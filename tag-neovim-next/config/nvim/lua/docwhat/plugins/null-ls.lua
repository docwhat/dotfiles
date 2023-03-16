return {
  'jay-babu/mason-null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mason.nvim',
    'plenary.nvim',
    {
      'jose-elias-alvarez/null-ls.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim',
        'ThePrimeagen/refactoring.nvim',
      },
      opts = function()
        local null_ls = require('null-ls')
        return {
          sources = {
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.gomodifytags,
            null_ls.builtins.code_actions.refactoring,
            null_ls.builtins.code_actions.shellcheck,
            --
            -- null_ls.builtins.diagnostics.actionlint,
            -- null_ls.builtins.diagnostics.fish,
            -- null_ls.builtins.diagnostics.flake8,
            -- null_ls.builtins.diagnostics.golangci_lint,
            -- null_ls.builtins.diagnostics.tfsec,
            -- null_ls.builtins.diagnostics.yamllint,
            null_ls.builtins.diagnostics.zsh,
            --
            -- null_ls.builtins.diagnostics.checkstyle.with({
            --   extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
            -- }),
            --
            -- null_ls.builtins.formatting.fish_indent,
            -- null_ls.builtins.formatting.gofumpt,
            -- null_ls.builtins.formatting.goimports_reviser,
            -- null_ls.builtins.formatting.prettierd,
            -- null_ls.builtins.formatting.shellharden,
            -- null_ls.builtins.formatting.stylua,
            -- null_ls.builtins.formatting.yamlfmt,
            -- null_ls.builtins.formatting.yq,
            --
            null_ls.builtins.hover.dictionary,
          },
        }
      end,
    },
  },
  opts = {
    automatic_setup = true,
    automatic_installation = false,
    ensure_installed = {
      'editorconfig-checker',
      'hadolint',
      'jsonlint',
      'luacheck',
      'markdownlint',
      'prettierd',
      'shellcheck',
      'shfmt',
      'stylua',
      'yamlfmt',
      'yamllint',
    },
  },
}
