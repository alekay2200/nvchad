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
    lazy = false,
    config = function()
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
    end
  },

  -- LazyGit --
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
  },

  -- Git-conflict --
  {
    'akinsho/git-conflict.nvim',
    dependencies = {
        'yorickpeterse/nvim-pqf'
    },
    lazy = false,
    version = "*",
    config = function()
        require('pqf').setup()
        require("git-conflict").setup({
          default_mappings = {
            ours = 'o',
            theirs = 't',
            none = '0',
            both = 'b',
            next = 'n',
            prev = 'p',
          },
            default_commands = true,    -- disable commands created by this plugin
            disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = 'copen',      -- command or function to open the conflicts list
            highlights = {              -- They must have background color, otherwise the default color will be used
                incoming = 'DiffAdd',
                current  = 'DiffText',
            },
        })

        -- vim.keymap.set('n', '<leader>gc', ':GitConflictRefresh<CR>', {noremap = true, silent = true})
        -- vim.keymap.set('n', '<leader>gq', ':GitConflictQf<CR>', {noremap = true, silent = true})

        vim.api.nvim_create_autocmd('User', {
            pattern = 'GitConflictDetected',
            callback = function()
                vim.notify('Conflict detected in file ' .. vim.api.nvim_buf_get_name(0))
                vim.cmd('LspStop')
            end
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'GitConflictResolved',
            callback = function()
                vim.cmd('LspRestart')
            end
        })
    end
  },

  -- Spectre search and repalce plugin
  {
    "nvim-pack/nvim-spectre",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require("spectre").setup({
        live_update = true
      })
    end
  },

  -- Multicursors Plugin
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-e>"] = cmp.mapping.abort(), -- close dialog
          ["<CR>"] = cmp.mapping.confirm( { select = false } ),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end
  },

  -- Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
