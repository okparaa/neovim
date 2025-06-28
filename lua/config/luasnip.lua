local luasnip = require("luasnip")
local types = require("luasnip.util.types")

luasnip.config.setup({
	history = true,
	update_events = "TextChanged,TextChangedI",
	delete_check_events = "TextChanged",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "GruvboxBlue" } },
			},
		},
	},
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
})

-- Load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "./isnippets" }, -- Add custom snippet path
})
