require "nvchad.autocmds"

local api = vim.api
local bo = vim.bo
local opt = vim.opt
local cmd = vim.cmd
local fn = vim.fn

-- Buffer Custom commands
-- Next buffer
api.nvim_create_user_command(
    "TabuflineNext",
    function() require("nvchad.tabufline").next() end,
    { nargs = 0 }
)

-- Prev Buffer command
api.nvim_create_user_command(
    "TabuflinePrev",
    function() require("nvchad.tabufline").prev() end,
    { nargs = 0 }
)

-- Prev Buffer command
api.nvim_create_user_command(
    "TabuflinePrev",
    function() require("nvchad.tabufline").prev() end,
    { nargs = 0 }
)

api.nvim_create_user_command(
    "TabuflineCloseCurrent",
    function() require("nvchad.tabufline").close_buffer() end,
    { nargs = 0 }
)

api.nvim_create_user_command(
    "TabuflineCloseLeft",
    function() require("nvchad.tabufline").closeBufs_at_direction("left") end,
    { nargs = 0 }
)

api.nvim_create_user_command(
    "TabuflineCloseRight",
    function() require("nvchad.tabufline").closeBufs_at_direction("right") end,
    { nargs = 0 }
)

api.nvim_create_user_command(
    "TabuflineMoveNext",
    function() require("nvchad.tabufline").move_buf(1) end,
    { nargs = 0 }
)

api.nvim_create_user_command(
    "TabuflineMovePrev",
    function() require("nvchad.tabufline").move_buf(-1) end,
    { nargs = 0 }
)


-- Disable expandtab option for go files
api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = "*",
    callback = function()
      if bo.filetype == "go" then
        opt.expandtab = false
      elseif bo.filetype == "make" then
        opt.expandtab = false
      else
        opt.expandtab = true
      end
    end
})

-- Resize nvimtree if the window was resized
api.nvim_create_autocmd({ "VimResized" }, {
  group = api.nvim_create_augroup("NvimTreeResize", { clear = true }),
  callback = function()
    local width = vim.go.columns
    cmd("NvimTreeResize " .. width)
  end,
})


local function align(opts)
  local text = opts.args
  local start_line = fn.line("'<") - 1
  local end_line = fn.line("'>")

  local lines = api.nvim_buf_get_lines(0, start_line, end_line, false)
  local new_lines = {}

  local big_index = 0
  for _, line in ipairs(lines) do
    local s, _ = string.find(line, text)
    if s ~= nil and big_index < s then big_index = s end
    local entry = { line = line, find_index = s }
    table.insert(new_lines, entry)
  end

  local modified_lines = {}
  for _, entry in ipairs(new_lines) do
    local line = entry["line"]
    local index = entry["find_index"]
    local spaces = big_index - index
    local new = line
    if spaces > 0 then
      new = line:sub(1, index - 1) .. string.rep(" ", spaces) .. line:sub(index)
    end
    table.insert(modified_lines, new)
  end

  api.nvim_buf_set_lines(0, start_line, end_line, false, modified_lines)
end

api.nvim_create_user_command("Align", align, { nargs = 1, range = true })
