local _, cmp = pcall(require, "cmp")
local _, devicons = pcall(require, "nvim-web-devicons")
local _, lsp = pcall(require, "lspconfig")
local _, lualine = pcall(require, "lualine")
local _, mason = pcall(require, "mason")
local _, masonlsp = pcall(require, "mason-lspconfig")
local _, telescope = pcall(require, "telescope")
local _, treesitter = pcall(require, "nvim-treesitter.configs")
local _, autotag = pcall(require, "nvim-ts-autotag")
local _, autopairs = pcall(require, "nvim-autopairs")
local _, neotree = pcall(require, "neo-tree")
local _, conform = pcall(require, "conform")
local _, comment = pcall(require, "Comment")

-- conform
conform.setup({
  format_on_save = {
    timeout_ms = 4000,
    lsp_format = "fallback",
  },
})

-- Comment
comment.setup()

-- Autopairs & Autotag
autotag.setup({
  filetypes = {
    "html",
    "svelte",
    "templ",
    "xml",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "twig" },
})
autopairs.setup({
  check_ts = true,
})

-- Treesitter
treesitter.setup({
  auto_install = true,
  highlight = { enable = true, },
  indent = { enable = true, },
})

-- Colorscheme
vim.cmd.colorscheme("kanagawa-wave")

-- Lualine
devicons.setup({})
lualine.setup({
  options = {
    disabled_filetypes = { "neo-tree" },
    section_separators = "",
  },
  sections = {
    lualine_b = { "diagnostics" },
    lualine_x = { "filetype" },
  },
})

-- Telescope
local actions = require("telescope.actions")
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
      },
    },
  },
})
telescope.load_extension("fzf")

-- Setup Mason and auto-install some LSPs
-- Mason handles the actual installations,
-- while mason-lspconfig does the automatation
-- and linking with novim-lspconfig
local capabilities = require("cmp_nvim_lsp").default_capabilities()
mason.setup()
masonlsp.setup({ automatic_installation = true })
masonlsp.setup_handlers({
  function(server)
    lsp[server].setup({ capabilities = capabilities })
  end,
})

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  severity_sort = true,
})

-- Gutter diagnostic signs
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = ""
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Neotree
neotree.setup({
  filesystem = {
    group_empty_dirs = true,
    filtered_items = {
      visible = true,
      show_hidden_count = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = {},
    }
  }
})

-- CMP
cmp.setup({
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  window = {
    documentation = cmp.config.disable,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  experimental = {
    ghost_text = true,
  },
})
