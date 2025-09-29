local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Telescope keymaps
map("n", "<C-p>", "<cmd>Telescope find_files<cr>")
map("n", "<leader>r", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>")
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")

-- LSP keymaps
map("n", "gd", vim.lsp.buf.definition)
map("n", "gr", vim.lsp.buf.references)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>ca", vim.lsp.buf.code_action)
map("n", "<leader>rn", vim.lsp.buf.rename)

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<C-d>", vim.diagnostic.open_float)

-- Explorer
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>")
map("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal current file in tree" })

-- Save file with Ctrl+S
map("n", "<C-s>", "<cmd>w<cr>")
-- map("i", "<C-s>", "<esc><cmd>w<cr>a")
map("i", "<C-s>", "<esc><cmd>w<cr>")

-- Toggle line comment
map({ "n", "v" }, "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

-- For block comments (optional)
map({ "n", "v" }, "<C-?>", function()
	require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle block comment" })

-- Terminal mode navigation
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Left window" })
map("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Down window" })
map("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Up window" })
map("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Right window" })

local term_buf = nil
local term_win = nil

local function toggle_terminal(direction)
	if term_win and vim.api.nvim_win_is_valid(term_win) then
		vim.api.nvim_win_close(term_win, true)
		term_win = nil
	else
		vim.cmd(direction == "h" and "belowright split" or "belowright vsplit")
		if not term_buf or not vim.api.nvim_buf_is_valid(term_buf) then
			term_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), term_buf)
			vim.cmd("terminal")
		else
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), term_buf)
		end
		term_win = vim.api.nvim_get_current_win()
		-- vim.cmd("startinsert")
	end
end

map("n", "<A-h>", function()
	toggle_terminal("h")
end, { desc = "Toggle horizontal terminal" })
map("n", "<A-v>", function()
	toggle_terminal("v")
end, { desc = "Toggle vertical terminal" })
map("n", "<A-f>", "<cmd>tabnew | terminal<cr>i", { desc = "Open terminal in new tab" })
map("n", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select All" })
map("i", "<C-a>", "<Esc>ggVG", { noremap = true, silent = true, desc = "Select All" })
map("v", "<C-a>", "ggVG", { noremap = true, silent = true, desc = "Select All" })

map("n", "<C-w>", ":bd<CR>", { noremap = true, silent = true })
