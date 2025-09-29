-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.g.mapleader = " "

-- Fix Ctrl+S for terminal
vim.cmd([[
  function! FixCtrlS()
    set ttimeout
    set ttimeoutlen=0
    set ttyfast
  endfunction
  autocmd VimEnter * call FixCtrlS()
]])

-- Load configurations
require("config.keymaps")

-- Load plugins with lazy.nvim
require("lazy").setup("plugins", {
  install = {
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
})

-- Set colorscheme after plugins are loaded
vim.cmd.colorscheme("tokyonight")
