local opt = vim.opt

opt.number = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.guicursor = ""

-- Specify xsel instead of slow lookup
vim.g.clipboard = {
  copy = {
    ["+"] = "xsel --clipboard --input",
    ["*"] = "xsel --clipboard --input",
  },
  paste = {
    ["+"] = "xsel --clipboard --output",
    ["*"] = "xsel --clipboard --output",
  },
}

opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.mouse = "a"
opt.undofile = true

opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.cursorline = true
opt.showmode = false
opt.termguicolors = true
opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
opt.splitright = true
opt.shadafile = "NONE"

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smarttab = true

vim.cmd(":command TrimWhitespace %s/\\s\\+$//e") -- Remove trailing whitespace
