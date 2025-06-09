require("nvchad.configs.lspconfig").defaults()

local servers = { 
  "html", "prettier", "prettierd", "cssls", "tailwindcss", "ts_ls", "emmet_language_server", "eslint" 
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
