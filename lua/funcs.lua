local M = {}

function M.OpenClaudeCodeTerminal()
    vim.cmd("vnew")
    vim.cmd("terminal claude")
    vim.bo.bufhidden = "wipe"
    vim.cmd("startinsert")
end

return M
