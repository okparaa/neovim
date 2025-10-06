local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Fix Ctrl+S in terminal
augroup("TerminalBehavior", { clear = true })
autocmd("VimEnter", {
	group = "TerminalBehavior",
	pattern = "*",
	callback = function()
		vim.opt.timeout = true
		vim.opt.timeoutlen = 300
		vim.opt.ttimeout = true
		vim.opt.ttimeoutlen = 0
		vim.opt.ttyfast = true
	end,
})

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Format on save for specific filetypes
augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
	group = "AutoFormat",
	pattern = { "*.lua", "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.css", "*.html" },
	callback = function()
		require("conform").format({ async = false, lsp_fallback = true })
	end,
})

-- Close some filetypes with <q>
augroup("CloseWithQ", { clear = true })
autocmd("FileType", {
	group = "CloseWithQ",
	pattern = {
		"help",
		"man",
		"notify",
		"lspinfo",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"PlenaryTestPopup",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
