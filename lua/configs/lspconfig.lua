-- require("nvchad.configs.lspconfig").defaults()
--
-- local servers = { 
--   "html", "prettier", "prettierd", "cssls", 
--   "tailwindcss", "emmet_language_server", "eslint", "clangd" 
-- }
--
-- vim.lsp.enable(servers)

local core_config = require("nvchad.configs.lspconfig")
local on_attach = core_config.on_attach
local capabilities = core_config.capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- Remove ts_ls from servers list
local servers = { 
  "html", "cssls", "tailwindcss", 
  "emmet_language_server", "eslint", "clangd" 
}

-- Default LSP setup for non-TS servers
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- ESLint requires special configuration
lspconfig.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    format = true,
    autoFixOnSave = true,
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
}

-- Export TypeScript tools setup
M = {}
function M.setup_typescript_tools()
  -- Disable default tsserver
  -- lspconfig.tsserver.setup({})

  -- Safe require for typescript-tools
  local ok, tstools = pcall(require, "typescript-tools")
  if not ok then
    vim.notify("typescript-tools not available", vim.log.levels.WARN)
    return
  end

  tstools.setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      
      -- Add custom keymaps
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
  }
end

return M
