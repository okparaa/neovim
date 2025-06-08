-- lua/custom/utils.lua
local M = {}

function M.save_sequence()
  -- Exit insert mode if needed
  local cursor_pos = vim.api.nvim_win_get_cursor(0)  -- Save cursor position

  if vim.api.nvim_get_mode().mode:match("i") then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  end

  -- Run formatter synchronously
  require("conform").format({ lsp_fallback = true, async = false })
  
  -- Execute quote conversion only if pattern exists
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local pattern_found = false
  
  -- Check if pattern exists in any line
  for _, line in ipairs(lines) do
    if line:match([[(^|[^\]')'([^']*[^\])']]) then
      pattern_found = true
      break
    end
  end

  if pattern_found then
    vim.cmd([[silent! %s/\(^\|[^\\]\)'\([^']*[^\\]\)'/\1\"\2\"/g]])
  end
  
  -- Save file and clear modified flag
  vim.cmd("silent write")
  vim.cmd("set nomodified")
  
  -- Notification with pattern status
  if pattern_found then
    vim.notify("Saved, formatted with double quotes", vim.log.levels.INFO)
  else
    vim.notify("Saved and formatted (no quotes)", vim.log.levels.INFO)
  end
  vim.api.nvim_win_set_cursor(0, cursor_pos)  -- Restore cursor position
end

return M
