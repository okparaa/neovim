return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = { "hrsh7th/nvim-cmp" }, -- Make sure cmp loads before integration
	config = function()
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		-- Setup autopairs
		npairs.setup({
			check_ts = true, -- enable Treesitter integration
			ts_config = {
				lua = { "string" }, -- don't add pairs in lua strings
				javascript = { "template_string" },
				java = false,
			},
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%)%}%,]]=],
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- Add rule: space inside brackets
		npairs.add_rules({
			Rule(" ", " "):with_pair(function(opts)
				return vim.tbl_contains({ "()", "[]", "{}" }, opts.line:sub(opts.col - 1, opts.col))
			end),
		})

		-- ✅ Integrate with nvim-cmp safely
		local ok_cmp, cmp = pcall(require, "cmp")
		if ok_cmp then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
