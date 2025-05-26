-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 
local utils = require("nvchad.stl.utils")

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onedark",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }

-- Modify file function to show relative path of the file instead of only the name
local customFile = function()
  local x = utils.file()
  local icon = x[1]
  -- local name = x[2]
  local relative_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
  local name = " " .. relative_path
  if relative_path == "" then name = " Empty" end
  return "%#StText# " .. icon .. name
end

M.ui = {
  statusline = {
    modules = {
      file = customFile
    }
  }
}

return M
