local opt = vim.opt

opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.signcolumn = "yes"

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
opt.shell = "/bin/bash"
opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
opt.splitright = true
opt.splitbelow = true

-- Indenting
opt.expandtab = true
opt.smartindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smarttab = true

-- Disable Inbuilt plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Remove trailing whitespace
vim.cmd(":command RemoveTrailingWhitespace %s/\\s\\+$//e")
