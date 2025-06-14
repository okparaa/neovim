require "nvchad.mappings"
-- local utils = require "custom.utils"
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local function wrap_quotes()
  vim.cmd('normal! ciw"')
  vim.api.nvim_put({vim.fn.getreg('"')}, 'c', true, true)
  vim.cmd('normal! a"')
end

map("n", "<leader>q", wrap_quotes, { desc = "Wrap word in quotes" })
