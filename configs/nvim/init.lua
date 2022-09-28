vim.loader.enable()
vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

local opt = vim.opt
opt.winborder = 'rounded'
opt.number = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.guicursor = ""
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.undofile = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.cursorline = true
opt.showmode = false
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
opt.shadafile = "NONE"
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2

vim.diagnostic.config({
  underline = false,
})

-- Remove trailing whitespace
vim.cmd("command! Trim %s/\\s\\+$//e")

vim.g.mapleader = " "
local map = vim.keymap.set
map("n", "<leader>s", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>n", ":noh<CR>")
map("n", "<leader>a", "@q")
map("n", "<Tab>", "<Nop>")
map("n", "dw", "diw")
map("n", "yw", "yiw")
map("n", "vw", 'viw')
map("n", "x", '"_x')
map("v", "p", "pgvy")
map("v", "c", '"_c')
map("n", "cc", '"_cc')
map("n", "cw", '"_ciw')

map("n", "<leader>p", ":Pick files<CR>")
map("n", "<leader>g", ":Pick grep_live<CR>")
map("n", "<leader>ld", vim.lsp.buf.definition)
map("n", "<leader>li", vim.lsp.buf.implementation)
map("n", "<leader>h", vim.lsp.buf.hover)
map("n", "<leader>r", vim.lsp.buf.rename)
map("n", "<leader>e", vim.diagnostic.open_float)


-- vim.pack.add({
--   "nvim-mini/mini.pick",
--   "nvim-mini/mini.statusline"
-- })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  defaults = { lazy = false },
  spec = {
    { "nvim-mini/mini.icons",      opts = {} },
    { "nvim-mini/mini.completion", opts = {} },
    { 'nvim-mini/mini.pairs',      opts = {} },
    { "nvim-mini/mini.statusline", opts = {} },
    { "nvim-mini/mini.pick",       opts = {}, cmd = "Pick" },
    {
      'stevearc/conform.nvim',
      opts = {
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      }
    },
    {
      "kvrohit/rasmus.nvim",
      priority = 1000,
      config = function()
        vim.cmd([[colorscheme rasmus]])
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      main = "nvim-treesitter.configs",
      opts = {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
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
})
