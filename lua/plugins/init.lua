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
}
