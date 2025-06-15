local M = {}

M.typescript = {
  n = {
    ["<leader>co"] = { "<cmd>TSToolsOrganizeImports<CR>", "Organize imports" },
    ["<leader>cR"] = { "<cmd>TSToolsRenameFile<CR>", "Rename file" },
    ["<leader>ci"] = { "<cmd>TSToolsAddMissingImports<CR>", "Add missing imports" },
    ["<leader>cu"] = { "<cmd>TSToolsRemoveUnusedImports<CR>", "Remove unused imports" },
    ["<leader>cF"] = { "<cmd>TSToolsFixAll<CR>", "Fix all" },
  }
}

return M
