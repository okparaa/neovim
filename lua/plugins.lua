return {
  -- Mason - LSP Package Manager
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
        "sqls",
        "prettier",
        "lua-language-server",
        "stylua",
      }
      for _, pkg in ipairs(packages) do
        if not registry.is_installed(pkg) then
          registry.get_package(pkg):install()
        end
      end
    end,
  },

  -- LSP Configuration (Fixed for Neovim 0.11.2)
  -- LSP Configuration (Updated for Neovim 0.11+)
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "MunifTanjim/eslint.nvim",
  },
  config = function()
    local eslint = require("eslint")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    eslint.setup({
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
      working_directory = {
        mode = "location",
        local_config_only = false,
      },
    })

    -- Define configurations for each server individually
    -- TypeScript/JavaScript
    vim.lsp.config('tsserver', { -- 🚨 First argument is a string: 'tsserver'
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      root_dir = vim.fs.dirname(vim.fs.find({'.git', 'package.json'}, { upward = true })[1]),
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
      capabilities = capabilities,
    })

    -- Tailwind CSS
    vim.lsp.config('tailwindcss', { -- 🚨 First argument is a string: 'tailwindcss'
      cmd = { 'tailwindcss-language-server', '--stdio' },
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      init_options = {
        userLanguages = {
          typescript = "javascript",
          typescriptreact = "javascript",
        },
      },
      capabilities = capabilities,
    })

    -- Emmet
    vim.lsp.config('emmet_ls', { -- 🚨 String: 'emmet_ls'
      cmd = { 'emmet-language-server', '--stdio' },
      filetypes = { "css", "html", "javascriptreact", "typescriptreact" },
      capabilities = capabilities,
    })

    -- Lua
    vim.lsp.config('lua_ls', { -- 🚨 String: 'lua_ls'
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
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
      capabilities = capabilities,
    })

    -- SQLS
    vim.lsp.config('sqls', { -- 🚨 String: 'sqls'
      cmd = { 'sqls' },
      filetypes = { 'sql' },
      capabilities = capabilities,
    })

    -- Enable all configured servers
    vim.lsp.enable({'tsserver', 'tailwindcss', 'emmet_ls', 'lua_ls', 'sqls'})
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
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
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
      vim.fn.delete(vim.fn.stdpath("data") .. "/treesitter", "rf")
      require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
      vim.filetype.add({
        extension = {
          tsx = "typescriptreact",
          ts = "typescript",
        },
      })

      require("nvim-treesitter.configs").setup({
        modules = {},
        ignore_install = {},
        auto_install = true,
        sync_install = false,
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
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
        matchup = { enable = true },
        filetype = {
          enable = true,
          disable = {},
          custom = {
            ["*.ts"] = "typescript",
            ["*.tsx"] = "tsx",
          },
        },
      })

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

  -- Colorscheme
  {
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
    end,
  },

  -- Status Line
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

  -- Buffer Line
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
          relativenumber = false,
          width = 30,
          side = "left",
        },
        filters = {
          dotfiles = true,
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          add_trailing = false,
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
          highlight_git = true,
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
  },

  -- Comment Toggler
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
            local U = require("Comment.utils")
            local location = nil

            if ctx.ctype == U.ctype.blockwise then
              location = require("ts_context_commentstring.utils").get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

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

  -- Auto Pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
        },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
        },
      })

      npairs.add_rules({
        Rule(" ", " "):with_pair(function(opts)
          return vim.tbl_contains({ "()", "[]", "{}" }, opts.line:sub(opts.col - 1, opts.col))
        end),
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = function()
      local ls = require("luasnip")

      ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })

      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })

      vim.keymap.set("i", "<C-k>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
}
