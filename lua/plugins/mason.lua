return {
	"williamboman/mason.nvim",
	build = ":MasonUpdate",
	config = function()
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		local registry = require("mason-registry")
		local packages = {
			"typescript-language-server",
			"tailwindcss-language-server",
			"emmet-language-server",
			"eslint_d",
			"sqls",
			"prettierd",
			"lua-language-server",
			"stylua",
			"css-lsp",
			"html-lsp",
			"json-lsp",
			"pyright",
			"rust-analyzer",
		}

		for _, pkg in ipairs(packages) do
			if not registry.is_installed(pkg) then
				registry.get_package(pkg):install()
			end
		end
	end,
}
