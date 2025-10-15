return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-tree").setup({
			view = {
				width = 24,
				side = "left",
			},
			filters = {
				dotfiles = true,
				git_ignored = true,
			},
			git = {
				enable = true,
				ignore = true,
			},
			renderer = {
				highlight_git = true,
				group_empty = true,
				icons = {
					show = {
						git = true,
						file = true,
						folder = true,
						folder_arrow = true,
					},
				},
				root_folder_label = function(path)
					local home = os.getenv("HOME")
					if path:find(home, 1, true) == 1 then
						return "~" .. path:sub(#home + 1)
					end
					return vim.fn.fnamemodify(path, ":t")
				end,
			},
		})
	end,
}
