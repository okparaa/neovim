return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			transparent = false,
			terminal_colors = true,
			styles = {
				comments = { italic = true },
				keywords = { italic = false },
			},
		})
		vim.cmd.colorscheme("tokyonight")

		-- Deep blue highlight for matching pairs
		vim.api.nvim_set_hl(0, "MatchParen", { fg = "#1E90FF", bold = true })

		-- Reapply highlight if colorscheme reloads
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "tokyonight",
			callback = function()
				vim.api.nvim_set_hl(0, "MatchParen", { fg = "#1E90FF", bold = true })
			end,
		})
	end,
}
