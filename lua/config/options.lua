vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.textwidth = 85
vim.opt.formatoptions = "t"
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.breakat = " \t;:,!?[]{}()"
vim.opt.showbreak = "↳ "
vim.opt.breakindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.wrap = true
		vim.opt.linebreak = true
	end,
})

vim.g.mapleader = " "
vim.g.maplocalleader = " "
