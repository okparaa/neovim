require "nvchad.mappings"
-- local utils = require "custom.utils"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("i", "<C-s>", "<ESC>:w<CR>", { desc = "Save file in Insert mode" })

-- map("n", "<leader>cq", ":%s/\\(^\\|[^\\\\]\\)"\\([^"]*[^\\\\]\\)'/\\1\"\\2\"/g<CR>", {
--   noremap = true,
--   silent = true,
--   desc = "Convert single to double quotes"
-- })

map("n", "<leader>ru", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.removeUnusedImports" } },
    apply = true
  })
end, { desc = "Remove unused imports" })

-- map("n", "<C-s>", utils.save_sequence, { desc = "Save sequence" })

-- Insert mode mapping
-- map("i", "<C-s>", utils.save_sequence, { desc = "Save sequence and exit insert" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
