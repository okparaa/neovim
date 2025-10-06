local M = {}

M.term_buf = nil
M.term_win = nil

function M.toggle_terminal(direction)
	if M.term_win and vim.api.nvim_win_is_valid(M.term_win) then
		vim.api.nvim_win_close(M.term_win, true)
		M.term_win = nil
	else
		vim.cmd(direction == "h" and "belowright split" or "belowright vsplit")
		if not M.term_buf or not vim.api.nvim_buf_is_valid(M.term_buf) then
			M.term_buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), M.term_buf)
			vim.cmd("terminal")
		else
			vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), M.term_buf)
		end
		M.term_win = vim.api.nvim_get_current_win()
	end
end

return M
