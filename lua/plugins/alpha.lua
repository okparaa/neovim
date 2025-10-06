return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- OKPARA ASCII Art Banner
		dashboard.section.header.val = {
			"          .:'       ",
			"      __ :'__       ",
			"   .'`__`-'__``.    ",
			"  :__________.-'    ",
			"  :_________:       ",
			"   :_________`-;    ",
			"    `.__.-.__.'     ",
		}

		-- Footer with plugin stats
		local function footer()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			return "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
		end
		dashboard.section.footer.val = footer()

		-- Apply syntax highlighting
		dashboard.section.header.opts.hl = "Keyword"
		dashboard.section.buttons.opts.hl = "Function"
		dashboard.section.footer.opts.hl = "Type"

		-- Setup alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
