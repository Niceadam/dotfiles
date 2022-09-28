local _, cmp = pcall(require, "cmp")
local _, dap = pcall(require, "dap")
local _, dapui = pcall(require, "dapui")
local _, devicons = pcall(require, "nvim-web-devicons")
local _, lsp = pcall(require, "lspconfig")
local _, lualine = pcall(require, "lualine")
local _, mason = pcall(require, "mason")
local _, masonlsp = pcall(require, "mason-lspconfig")
local _, telescope = pcall(require, "telescope")
local _, treesitter = pcall(require, "nvim-treesitter.configs")
local _, autotag = pcall(require, "nvim-ts-autotag")
local _, autopairs = pcall(require, "nvim-autopairs")
local _, saga = pcall(require, "lspsaga")

-- Autopairs & Autotag
autotag.setup({})
autopairs.setup({
  check_ts = true,
})

-- Treesitter
treesitter.setup({
  ensure_installed = "all",
  autotag = { enable = true },
  highlight = {
    enable = true,
  },
})

-- Colorscheme
devicons.setup()
vim.cmd("set background=dark")
vim.cmd("let g:gruvbox_material_background = 'hard'")
vim.cmd("colorscheme gruvbox-material")

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
vim.cmd("highlight SignColumn guibg=dark")

-- Lualine
lualine.setup({
  theme = "gruvbox-material",
  options = { section_separators = '' },
  sections = {
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

-- Mason Lsp Installer
mason.setup()
masonlsp.setup({
  ensure_installed = { "clangd" },
  automatic_installation = true,
})

-- LSP servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
masonlsp.setup_handlers({
  function(server_name)
    lsp[server_name].setup({
      capabilities = capabilities,
    })
  end,
})

-- Lspsaga
saga.init_lsp_saga({
  code_action_lightbulb = { enable = false, sign = false }
})

-- Gutter diagnostic signs
local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Diagnotic settings
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = true
})

vim.lsp.handlers["textDocument/publishDiagnostics"] =
vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, { underline = false }
)

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
    documentation = cmp.config.disable
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require("lspkind").cmp_format({
      mode = "symbol",
      with_text = false
    })
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
dapui.setup({})
dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
}
dap.configurations.cpp = {
  name = "Launch",
  type = "lldb",
  request = "launch",
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
