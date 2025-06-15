-- Disable default tsserver
require("lspconfig").tsserver.setup({})

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

require("typescript-tools").setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    
    -- Add custom keymaps specific to TypeScript
    local map = vim.keymap.set
    local opts = { buffer = bufnr, silent = true }
    
    map("n", "<leader>co", "<cmd>TSToolsOrganizeImports<CR>", opts)
    map("n", "<leader>cR", "<cmd>TSToolsRenameFile<CR>", opts)
    map("n", "<leader>ci", "<cmd>TSToolsAddMissingImports<CR>", opts)
    map("n", "<leader>cu", "<cmd>TSToolsRemoveUnusedImports<CR>", opts)
    map("n", "<leader>cF", "<cmd>TSToolsFixAll<CR>", opts)
  end,
  capabilities = capabilities,
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
    },
    tsserver_format_options = {
      insertSpaceAfterCommaDelimiter = true,
      insertSpaceAfterSemicolonInForStatements = true,
      insertSpaceBeforeAndAfterBinaryOperators = true,
      insertSpaceAfterConstructor = true,
      indentSize = 2,
      tabSize = 2,
    },
  },
})
