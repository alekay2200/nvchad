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
