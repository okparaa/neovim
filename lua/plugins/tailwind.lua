return {
	"tailwindlabs/tailwindcss-intellisense",
	ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
			callback = function()
				require("tailwindcss-intellisense").setup()
			end,
		})
	end,
}
