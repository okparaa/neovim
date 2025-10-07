return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Art Banner
		dashboard.section.header.val = {
			"          .:'       ",
			"      __ :'__       ",
			"   .'`__`-'__``.    ",
			"  :__________.-'    ",
			"  :_________:       ",
			"   :_________`-;    ",
			"    `.__.-.__.'     ",
		}

		-- Set menu buttons
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "󰊄  Find File", ":Telescope find_files<CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
			dashboard.button("t", "󰈬  Find Text", ":Telescope live_grep<CR>"),
			dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua<CR>"),
			dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
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
