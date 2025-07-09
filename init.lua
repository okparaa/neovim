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

-- Add to your init.lua or config
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescriptreact", "javascriptreact" },
	callback = function()
		-- Force JSX completion
		vim.b._tsx_completion_activated = true
		vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Set proper syntax
		vim.cmd("syntax enable")
		vim.cmd("set syntax=typescriptreact")
	end,
})
