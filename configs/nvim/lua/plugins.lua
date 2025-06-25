return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },

  { "nvim-mini/mini.icons",      opts = {} },
  { "nvim-mini/mini.completion", opts = {} },
  { 'nvim-mini/mini.pairs',      opts = {} },
  { "nvim-mini/mini.statusline", opts = {} },
  { "nvim-mini/mini.pick",       opts = {} },

  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        timeout_ms = 4000,
        lsp_format = "fallback",
      },
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      auto_install = true,
      highlight = { enable = true, },
      indent = { enable = true, },
    }
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig"
    },
  }
}
