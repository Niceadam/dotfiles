-- Automatically install packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

-- Sync automatically on updating plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local present, _ = pcall(require, "packer")
if not present then
  return
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  use({
    "wbthomason/packer.nvim",
    "kyazdani42/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "ThePrimeagen/harpoon",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",

    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "onsails/lspkind-nvim",
    "sbdchd/neoformat",

    "sainnhe/gruvbox-material",
    "nvim-lualine/lualine.nvim",

    "nvim-treesitter/nvim-treesitter",
    "windwp/nvim-autopairs",
    "windwp/nvim-ts-autotag",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  })

  use({ "glepnir/lspsaga.nvim", branch = "main" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
