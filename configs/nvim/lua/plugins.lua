return {
  "kyazdani42/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "ThePrimeagen/harpoon",

  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",

  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  "rebelot/kanagawa.nvim",
  { "nvim-lualine/lualine.nvim",                lazy = false },

  'stevearc/conform.nvim',
  "nvim-treesitter/nvim-treesitter",
  "windwp/nvim-autopairs",
  "windwp/nvim-ts-autotag",
  "numToStr/Comment.nvim",

  { 'Exafunction/codeium.vim',     event = 'BufEnter' },

  "MunifTanjim/nui.nvim",
  { "nvim-neo-tree/neo-tree.nvim", branch = "v3.x",   lazy = true }
}
