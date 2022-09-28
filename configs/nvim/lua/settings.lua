local _, cmp = pcall(require, "cmp")
-- local _, dap = pcall(require, "dap")
-- local _, dapui = pcall(require, "dapui")
local _, devicons = pcall(require, "nvim-web-devicons")
local _, lsp = pcall(require, "lspconfig")
local _, lualine = pcall(require, "lualine")
local _, mason = pcall(require, "mason")
local _, masonlsp = pcall(require, "mason-lspconfig")
local _, telescope = pcall(require, "telescope")
local _, treesitter = pcall(require, "nvim-treesitter.configs")
local _, autotag = pcall(require, "nvim-ts-autotag")
local _, autopairs = pcall(require, "nvim-autopairs")

-- Autopairs & Autotag
autotag.setup({
  filetypes = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml", "svelte", "tmpl", "twig" },
})
autopairs.setup({
  check_ts = true,
})

-- Treesitter
treesitter.setup({
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = { "php" },
  }
})

-- Colorscheme
vim.opt.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.cmd.colorscheme("gruvbox-material")

-- Lualine
devicons.setup({})
lualine.setup({
  options = {
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
-- and linking with neovim-lspconfig
mason.setup({
  providers = {
    "mason.providers.client",
    "mason.providers.registry-api",
  },
})

masonlsp.setup({
  automatic_installation = true,
})

-- LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()
masonlsp.setup_handlers({
  function(server)
    lsp[server].setup({
      capabilities = capabilities,
    })
  end,
})

-- Diagnostic settings
vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  severity_sort = true,
})

-- Gutter diagnostic signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- CMP
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Down>"] = cmp.mapping.select_next_item(),
    ["<Up>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  window = {
    documentation = cmp.config.disable,
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require("lspkind").cmp_format({
      mode = "symbol",
      with_text = false,
    }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "luasnip" },
  },
  experimental = {
    ghost_text = true,
  },
})

-- Debugging
-- dapui.setup({})
-- dap.adapters.lldb = {
-- 	type = "executable",
-- 	command = "/usr/bin/lldb-vscode",
-- 	name = "lldb",
-- }
-- dap.configurations.cpp = {
-- 	name = "Launch",
-- 	type = "lldb",
-- 	request = "launch",
-- }
-- dap.configurations.c = dap.configurations.cpp
-- dap.configurations.rust = dap.configurations.cpp
