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

-- no-yank delete: s, x, p
keymap("n", "x", '"_x', opts)
keymap("v", "s", '"_d', opts)
keymap("v", "p", "pgvy", opts)
keymap("n", "ss", '"_dd', opts)
keymap("n", "sw", '"_diw', opts)

-- no-yank delete-insert: c
keymap("v", "c", '"_c', opts)
keymap("n", "cc", '"_cc', opts)
keymap("n", "cw", '"_ciw', opts)

-- Telescope
keymap("n", "<leader>p", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>g", ":Telescope live_grep<CR>", opts)

-- LSP
keymap("n", "<leader>ll", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>lr", ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
keymap("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>lk", ":lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>e", ":lua vim.diagnostic.open_float()<CR>", opts)

-- Neotree
keymap("n", "<leader>t", ":Neotree reveal<CR>", opts)

-- Harpoon
keymap("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>j", ":lua require('harpoon.ui').nav_prev()<CR>", opts)
keymap("n", "<leader>k", ":lua require('harpoon.ui').nav_next()<CR>", opts)
