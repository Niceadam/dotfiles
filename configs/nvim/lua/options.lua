local opt = vim.opt

opt.number = true
opt.numberwidth = 2
opt.signcolumn = "yes"
opt.guicursor = ""
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.mouse = "a"
opt.undofile = true

-- Specify xsel instead of slow lookup
vim.g.clipboard = {
  copy = {
    ["+"] = "waycopy",
    ["*"] = "waycopy",
  },
  paste = {
    ["+"] = "waypaste",
    ["*"] = "waypaste",
  },
}

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


-- Diagnostic settings
vim.diagnostic.config({
  underline = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = ""
    }
  }
})

vim.cmd(":command TrimWhitespace %s/\\s\\+$//e") -- Remove trailing whitespace
