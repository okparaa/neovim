return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.timeout = true
		vim.opt.timeoutlen = 300
	end,
	config = function()
		local wk = require("which-key")
		local terminal = require("config.terminal")

		wk.setup({
			plugins = {
				marks = true,
				registers = true,
				spelling = { enabled = true, suggestions = 20 },
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
			win = {
				border = "rounded",
				position = "bottom",
				margin = { 1, 0, 1, 0 },
				padding = { 2, 2, 2, 2 },
				winblend = 0,
			},
			layout = {
				height = { min = 4, max = 25 },
				width = { min = 20, max = 50 },
				spacing = 3,
				align = "left",
			},
			show_help = true,
			triggers = { "auto" },
		})

		-- ✅ New spec-style mappings
		wk.add({
			-- 🗂️ File group
			{ "<leader>f", group = "file" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffer" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find help" },
			{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "Find references" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find diagnostics" },

			-- 📁 Explorer group
			{ "<leader>e", group = "explorer" },
			{ "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "Refresh" },
			{ "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file" },

			-- 🔍 Search / grep
			{ "<leader>r", "<cmd>Telescope live_grep<cr>", desc = "Ripgrep search" },

			-- 🧠 Code group
			{ "<leader>c", group = "code" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code action" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

			-- 🔧 Non-leader mappings
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
			{ "<C-s>", "<cmd>w<cr>", desc = "Save file" },
			{ "<C-d>", vim.diagnostic.open_float, desc = "Line diagnostics" },
			{ "<A-f>", "<cmd>tabnew | terminal<cr>i", desc = "Open terminal in new tab" },
			{ "<C-a>", "ggVG", desc = "Select all" },

			-- 🧭 LSP and diagnostics
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
			{ "gr", vim.lsp.buf.references, desc = "Go to references" },
			{ "K", vim.lsp.buf.hover, desc = "Hover documentation" },
			{
				"[d]",
				function()
					vim.diagnostic.jump({ count = -1, float = true })
				end,
				desc = "Previous diagnostic",
			},
			{
				"]d",
				function()
					vim.diagnostic.jump({ count = 1, float = true })
				end,
				desc = "Next diagnostic",
			},

			-- 🖥️ Terminal controls
			{
				"<A-h>",
				function()
					terminal.toggle_terminal("h")
				end,
				desc = "Toggle horizontal terminal",
			},
			{
				"<A-v>",
				function()
					terminal.toggle_terminal("v")
				end,
				desc = "Toggle vertical terminal",
			},
		})
	end,
}
