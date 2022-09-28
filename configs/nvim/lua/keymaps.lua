local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- commands
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>n", ":noh<CR>", opts)

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
keymap("v", "p", 'pgvy', opts)

-- no-yank replace: c
keymap("n", "cc", '"_cc', opts)
keymap("n", "cw", '"_ciw', opts)
keymap("n", "c{", '"_ci{', opts)
keymap("n", "c(", '"_ci(', opts)
keymap("n", "c[", '"_ci[', opts)
keymap("v", "c", '"_c', opts)

keymap("n", "q", "<S-v>", opts) -- Visual Line
keymap("n", "t", "<C-v>", opts) -- Visual Block

-- Telescope
keymap("n", "<leader>p", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>of", ":Telescope lsp_references<CR>", opts)
keymap("n", "<leader>og", ":Telescope grep_string<CR>", opts)
keymap("n", "<leader>oc", ":Telescope buffers<CR>", opts)

-- LSP
keymap("n", "<leader>gr", ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
keymap("n", "<leader>gR", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>gD", ":lua vim.lsp.buf.declaration()<CR>", opts)
keymap("n", "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>", opts)

-- Lspsaga
keymap("n", "<leader>e", ":Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "<leader>gk", ":Lspsaga hover_doc<CR>", opts)

-- Harpoon
keymap("n", "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", opts)
keymap("n", "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>j", ":lua require('harpoon.ui').nav_file(1)<CR>", opts)
keymap("n", "<leader>k", ":lua require('harpoon.ui').nav_file(2)<CR>", opts)
keymap("n", "<leader>l", ":lua require('harpoon.ui').nav_file(3)<CR>", opts)
