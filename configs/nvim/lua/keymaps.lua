local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- commands
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)
keymap("n", "<leader>r", "q", opts)

-- yank delete: d
keymap("n", "dw", "diw", opts)
keymap("n", "yw", "yiw", opts)

-- no-yank delete: s, x, p
keymap("n", "x", '"_x', opts)
keymap("n", "ss", '"_dd', opts)
keymap("n", "sw", '"_diw', opts)
keymap("n", "s{", '"_d{', opts)
keymap("n", "s}", '"_d}', opts)
keymap("v", "s", '"_d', opts)
keymap("v", "p", "pgvy", opts)

-- no-yank replace: c
keymap("n", "cc", '"_cc', opts)
keymap("n", "cw", '"_ciw', opts)
keymap("n", "c{", '"_ci{', opts)
keymap("n", "c(", '"_ci(', opts)
keymap("n", "c[", '"_ci[', opts)
keymap("v", "c", '"_c', opts)

-- Telescope
keymap("n", "<leader>p", ":Telescope find_files<CR>", opts)

keymap("n", "<leader>tf", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>tg", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>tc", ":Telescope buffers<CR>", opts)

-- LSP
keymap("n", "<leader>lr", ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
keymap("n", "<leader>lR", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", opts)
keymap("n", "<leader>lk", ":Lspsaga hover_doc<CR>", opts)

-- Lspsaga
keymap("n", "<leader>e", ":Lspsaga show_line_diagnostics<CR>", opts)

-- Harpoon
keymap("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>j", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>k", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
