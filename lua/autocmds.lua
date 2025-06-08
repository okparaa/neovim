require "nvchad.autocmds"
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    if vim.fn.mode() == "n" then
      vim.diagnostic.open_float(nil, {
        scope = "cursor",
        focusable = false,
        close_events = { "CursorMoved", "InsertEnter" }
      })
    end
  end
})

-- Adjust hover delay
vim.opt.updatetime = 300
