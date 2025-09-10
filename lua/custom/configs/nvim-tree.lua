-- nvim-tree
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = vim.o.columns,
        side = 'left',
    },
    renderer = {
        group_empty = false,
    },
    filters = {
        dotfiles = false,
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
})


-- Autocomando para actualizar el tamaño al hacer resize
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    local api = require("nvim-tree.api")
    if api.tree.is_visible() then
      api.tree.close()
      vim.defer_fn(function()
        api.tree.open()
      end, 100)
    end
  end,
})
