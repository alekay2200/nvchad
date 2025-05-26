return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = require "custom.configs.treesitter"
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    opts = {
        ensure_installed = require "custom.configs.mason-lspconfig",
        automatic_enable = true,
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
          sort = {
              sorter = "case_sensitive",
          },
          view = {
              -- width = 60,
              -- width = vim.api.nvim_get_option("columns"),
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
    end
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    keys = {
      {"<leader>g", "<cmd>LazyGit<cr>", desc = "Open Lazy git"}
    },

    config = function()
      vim.g.lazygit_floating_window_use_plenary = 0
      vim.g.lazygit_floating_window_scaling_factor = 1.0
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_border_chars = {'', '', '', '', '', '', '', ''}
    end
  }
}
