require "nvchad.options"
local o = vim.opt

-- Indenting
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.relativenumber = true

-- vim.diagnostic.config({
--   virtual_text = {
--     wrap = true,
--     spacing = 4,
--   },
--   float = {
--     border = "rounded",
--     focusable = false,
--     wrap = true,
--     max_width = 80,
--     header = "",
--     prefix = function(diagnostic)
--       local icons = {
--         Error = " ",
--         Warn = " ",
--         Info = " ",
--         Hint = " ",
--       }
--       local severity_name = vim.diagnostic.severity[diagnostic.severity]
--       return icons[severity_name] or "", "Diagnostic" .. severity_name
--     end,
--     format = function(diagnostic)
--       return string.format("%s (%s)", diagnostic.message, diagnostic.source or "unknown")
--     end
--   },
--   severity_sort = true,
--   underline = true,
--   update_in_insert = false,
-- })
-- Optional: Set custom highlight colors
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555", bold = true })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffb86c" })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#8be9fd" })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#bd93f9" })
