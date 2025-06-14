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

local function wrap_quotes()
  -- Get word under cursor (without surrounding non-word chars)
  local word = vim.fn.expand('<cword>')
  
  -- Get start and end positions of the word
  local start_col = vim.fn.matchstrpos(vim.fn.getline('.'), '\\<'..word..'\\>')[2]
  local end_col = start_col + #word - 1
  
  -- Replace with quoted version
  vim.api.nvim_buf_set_text(0, 
    vim.fn.line('.')-1, start_col,
    vim.fn.line('.')-1, end_col+1,
    {'"' .. word .. '"'})
end

map("n", "<leader>q", wrap_quotes, { desc = "Wrap word in quotes" })
