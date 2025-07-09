return {
	-- Mason with UI icons
	{
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
			-- Install required LSP servers
			local registry = require("mason-registry")
			local packages = {
				"typescript-language-server",
				"tailwindcss-language-server",
				"emmet-language-server",
				"eslint_d",
				"prettier",
			}
			for _, pkg in ipairs(packages) do
				if not registry.is_installed(pkg) then
					registry.get_package(pkg):install()
				end
			end
		end,
	},
	-- LSP Configuration
	--[[ {
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			-- Setup LSP servers
			local lspconfig = require("lspconfig")
			-- TypeScript setup
			lspconfig.ts_ls.setup({
				on_attach = function(client, _)
					client.server_capabilities.documentFormattingProvider = false
				end,
				filetypes = {
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
				},
				init_options = {
					preferences = {
						includeCompletionsForModuleExports = true,
						jsxAttributeCompletionStyle = "auto", -- Essential for React props
						allowTextChangesInNewFiles = true,
					},
					tsserver = {
						experimental = {
							enableProjectDiagnostics = true,
						},
					},
				},
			})

			lspconfig.emmet_language_server.setup({
				filetypes = {
					"css",
					"html",
					"javascriptreact",
					"typescriptreact",
				},
			})
			-- Tailwind CSS setup
			lspconfig.tailwindcss.setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				init_options = {
					userLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
					},
				},
			})
		end,
	}, ]]
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"jose-elias-alvarez/typescript.nvim", -- Enhanced TS/JS features
			"MunifTanjim/eslint.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local eslint = require("eslint")

			eslint.setup({
				bin = "eslint_d", -- Faster daemon version
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
					run_on = "save", -- Also try "save"
				},
				working_directory = {
					mode = "location", -- Crucial for Next.js projects
					local_config_only = false,
				},
			})

			lspconfig.ts_ls.setup({
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					on_attach = function(_, bufnr)
						local eslint_config = vim.fn.findfile(".eslintrc.*", ".;")
						if eslint_config ~= "" then
							require("lspconfig").eslint.setup({
								on_attach = function(eslint_client, _)
									eslint_client.server_capabilities.documentFormattingProvider = true
								end,
							})
						end
						-- Keymaps for TS/JS specific features
					end,
					settings = {
						typescript = {
							suggest = {
								autoImports = true,
								completeFunctionCalls = true,
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
						javascript = {
							suggest = {
								autoImports = true,
								completeFunctionCalls = true,
							},
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
							},
						},
					},
				},
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					completions = {
						completeFunctionCalls = true,
					},
				},
			})

			-- Tailwind CSS setup
			lspconfig.tailwindcss.setup({
				filetypes = {
					"html",
					"css",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				init_options = {
					userLanguages = {
						typescript = "javascript",
						typescriptreact = "javascript",
					},
				},
			})

			-- Lua LSP configuration
			lspconfig.lua_ls.setup({
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
				on_attach = function(client, _)
					-- Disable formatting capability (we'll use stylua instead)
					client.server_capabilities.documentFormattingProvider = false
				end,
			})
		end,
	},
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
						".next",
						"dist",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
					},
				},
			})
		end,
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},

	-- Tailwind CSS Enhancement
	{
		"tailwindlabs/tailwindcss-intellisense",
		ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
	},

	-- Syntax Highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			-- Force clean install
			vim.fn.delete(vim.fn.stdpath("data") .. "/treesitter", "rf")
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			-- Verify filetype detection
			vim.filetype.add({
				extension = {
					tsx = "typescriptreact",
					ts = "typescript",
				},
			})

			require("nvim-treesitter.configs").setup({
				-- Install parsers synchronously
				modules = {}, -- Can remain empty if not using custom modules
				ignore_install = {}, -- List of parsers to ignore (e.g., {"php"})
				auto_install = true,
				sync_install = false,
				-- Ensure parsers are installed
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"jsdoc",
				},
				-- Highlight configuration
				highlight = {
					enable = true,
					disable = {},
					additional_vim_regex_highlighting = false,
				},
				matchup = { enable = true },
				-- Important: Explicitly enable for filetypes
				filetype = {
					enable = true,
					disable = {},
					custom = {
						["*.ts"] = "typescript",
						["*.tsx"] = "tsx",
					},
				},
			})

			-- Manual fallback for highlighting
			vim.api.nvim_create_autocmd({ "BufEnter", "BufRead" }, {
				pattern = { "*.ts", "*.tsx" },
				callback = function()
					vim.cmd([[TSBufEnable highlight]])
				end,
			})
		end,
	},

	-- Linting
	{
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				javascript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	--[[ 	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- load it early so highlights aren't overridden
		config = function()
			require("catppuccin").setup({ -- customize options here
				flavour = "mocha",
				background = { dark = "moon" },
			})
			vim.cmd.colorscheme("catppuccin") -- apply the theme
		end,
	}, ]]
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Load first
		config = function()
			require("tokyonight").setup({
				style = "night", -- Options: night, storm, moon, day
				transparent = false, -- Enable for transparent background
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
				},
			})
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto",
				component_separators = "",
				section_separators = "",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				offsets = { { filetype = "neo-tree", text = "File Explorer" } },
			},
		},
	},
	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				view = {
					-- Show relative paths instead of absolute
					relativenumber = false, -- Show line numbers relative to cursor
					width = 30,
					side = "left", -- or "right"
				},
				filters = {
					dotfiles = true,
				},
				renderer = {
					indent_markers = {
						enable = true,
					},
					add_trailing = false, -- Add trailing slash to folders
					group_empty = true, -- Collapse empty folders
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
						},
					},
					highlight_git = true,
					-- Customize root folder display
					root_folder_label = function(path)
						local home = os.getenv("HOME")
						if path:find(home, 1, true) == 1 then
							return "~" .. path:sub(#home + 1)
						end
						return vim.fn.fnamemodify(path, ":t") -- Show only basename
					end,
				},
			})
		end,
	},
	-- Comment toggler
	{
		"numToStr/Comment.nvim",
		dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			require("Comment").setup({
				pre_hook = function(ctx)
					-- Only for TSX/JSX files
					if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
						local U = require("Comment.utils")
						local location = nil

						-- Determine location based on context
						if ctx.ctype == U.ctype.blockwise then
							location = require("ts_context_commentstring.utils").get_cursor_location()
						elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
							location = require("ts_context_commentstring.utils").get_visual_start_location()
						end

						-- Only calculate if we have a valid location
						if location then
							return require("ts_context_commentstring.internal").calculate_commentstring({
								key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline",
								location = location,
							})
						end
					end
				end,
			})
		end,
	},

	-- Formatting
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					json = { "prettier" },
					html = { "prettier" },
					css = { "prettier" },
					markdown = { "prettier" },
				},
				format_on_save = {
					timeout_ms = 2000,
					lsp_fallback = true,
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/nvim-cmp", -- optional integration
		},
		config = function()
			local npairs = require("nvim-autopairs")
			local Rule = require("nvim-autopairs.rule")

			npairs.setup({
				check_ts = true, -- treesitter integration
				ts_config = {
					lua = { "string" }, -- don't add pairs in lua strings
					javascript = { "template_string" }, -- no pairs in js template strings
				},
				fast_wrap = {
					map = "<M-e>", -- alt+e to jump between pair ends
					chars = { "{", "[", "(", '"', "'" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					end_key = "$",
					keys = "qwertyuiopzxcvbnmasdfghjkl",
					check_comma = true,
					highlight = "Search",
				},
			})

			-- Add spaces between parentheses (optional)
			npairs.add_rules({
				Rule(" ", " "):with_pair(function(opts)
					return vim.tbl_contains({ "()", "[]", "{}" }, opts.line:sub(opts.col - 1, opts.col))
				end),
			})

			-- CMP integration (if using nvim-cmp)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
