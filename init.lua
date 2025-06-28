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
vim.opt.number = true -- enable absolute line numbers
vim.opt.relativenumber = true
vim.cmd([[
   function! FixCtrlS()
     set ttimeout
     set ttimeoutlen=0
     set ttyfast
   endfunction
   autocmd VimEnter * call FixCtrlS()
 ]])

-- Basic settings
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.g.mapleader = " "

-- Load keymaps
require("config.keymaps")

-- Load plugins
require("lazy").setup("plugins")

require("plugins") -- Loads plugins/snippets.lua
require("config.luasnip") -- Loads snippet config
require("config.cmp") -- Loads snippet config
