local opt = vim.opt
local cmd = vim.cmd

-- Show spaces and tab
opt.list = true
opt.encoding = "utf-8"
-- opt.listchars = { lead = '·', tab = '» ' }

-- Tabs / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.wrap = true

-- Show float window with diagnostic information for current line
cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Cursor
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
