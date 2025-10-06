local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

local terminal = require("config.terminal")

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>r", "<cmd>Telescope live_grep<cr>", { desc = "Ripgrep search" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffer" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Find help" })
map("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", { desc = "Find references" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Find diagnostics" })

-- LSP
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

-- Diagnostics
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Previous diagnostic" })

map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

map("n", "<C-d>", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Explorer
map("n", "<C-n>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })
map("n", "<leader>er", "<cmd>NvimTreeRefresh<cr>", { desc = "Refresh file tree" })
map("n", "<leader>ef", "<cmd>NvimTreeFindFile<cr>", { desc = "Reveal current file in tree" })

-- Save file
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
map("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save file" })

-- Toggle line/block comment
map({ "n", "v" }, "<C-/>", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })

map({ "n", "v" }, "<C-?>", function()
	require("Comment.api").toggle.blockwise.current()
end, { desc = "Toggle block comment" })

-- Terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Left window" })
map("t", "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Down window" })
map("t", "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Up window" })
map("t", "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Right window" })

-- Terminal toggles
map("n", "<A-h>", function()
	terminal.toggle_terminal("h")
end, { desc = "Toggle horizontal terminal" })

map("n", "<A-v>", function()
	terminal.toggle_terminal("v")
end, { desc = "Toggle vertical terminal" })

map("n", "<A-f>", "<cmd>tabnew | terminal<cr>i", { desc = "Open terminal in new tab" })

-- Select All
map("n", "<C-a>", "ggVG", { desc = "Select All" })
map("i", "<C-a>", "<Esc>ggVG", { desc = "Select All" })
map("v", "<C-a>", "ggVG", { desc = "Select All" })

-- Close buffer
map("n", "<C-w>", ":bd<CR>", { desc = "Close buffer" })
