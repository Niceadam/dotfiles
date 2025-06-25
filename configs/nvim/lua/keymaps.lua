local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- commands
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)
keymap("n", "<Tab>", "<Nop>", opts)

-- qq: record
-- q: stop
-- replay:
keymap("n", "<leader>r", "@q", opts)

-- yank delete: d
keymap("n", "dw", "diw", opts)
keymap("n", "yw", "yiw", opts)
keymap("n", "vw", 'viw', opts)

-- no-yank delete: x, p
keymap("n", "x", '"_x', opts)
keymap("v", "p", "pgvy", opts)
keymap("n", "ss", '"_dd', opts)
keymap("n", "sw", '"_diw', opts)

-- no-yank delete-insert: c
keymap("v", "c", '"_c', opts)
keymap("n", "cc", '"_cc', opts)
keymap("n", "cw", '"_ciw', opts)

-- Telescope
keymap("n", "<leader>p", ":Pick files<CR>", opts)
keymap("n", "<leader>g", ":Pick grep_live<CR>", opts)

-- LSP
keymap("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>h", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>r", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)
