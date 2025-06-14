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

map("v", "<leader>q", [[<esc>`>o"<esc>`<O"<esc>gv]], { 
  desc = "Wrap multi-line selection in quotes" 
})

local function wrap_quotes()
  local start_pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd('normal! viw')
  local end_pos = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_set_text(0, start_pos[1]-1, start_pos[2], end_pos[1]-1, end_pos[2], {'"'})
  vim.api.nvim_buf_set_text(0, end_pos[1]-1, end_pos[2], end_pos[1]-1, end_pos[2], {'"'})
end

map("n", "<leader>q", wrap_quotes, { desc = "Wrap word in quotes" })
