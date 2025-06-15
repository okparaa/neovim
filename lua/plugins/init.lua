return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = require "configs.lspconfig"

  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    opts =  require "configs.treesitter"

  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
      view = { width = 30 },
      filters = { dotfiles = true }
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      -- Defer loading to ensure LSP config is ready
      vim.schedule(function()
        require("configs.lspconfig").setup_typescript_tools()
      end)
    end,
  },
}
