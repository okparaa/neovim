return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"MunifTanjim/eslint.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Configure ESLint using the eslint.nvim plugin
		require("eslint").setup({
			bin = "eslint_d",
			code_actions = {
				enable = true,
				apply_on_save = {
					enable = true,
					types = { "problem", "suggestion", "layout" },
				},
			},
			diagnostics = {
				enable = true,
				report_unused_disable_directives = false,
				run_on = "save",
			},
		})

		-- TypeScript/JavaScript using new API
		vim.lsp.config("ts_ls", {
			capabilities = capabilities,
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "all",
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
					},
				},
			},
		})

		-- Tailwind CSS
		vim.lsp.config("tailwindcss", {
			capabilities = capabilities,
		})

		-- Emmet
		vim.lsp.config("emmet_ls", {
			capabilities = capabilities,
			filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = { enable = false },
				},
			},
		})

		-- SQLS
		vim.lsp.config("sqls", {
			capabilities = capabilities,
		})

		-- Enable all LSP configurations
		local servers = { "ts_ls", "tailwindcss", "emmet_ls", "lua_ls", "sqls" }
		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end
	end,
}
