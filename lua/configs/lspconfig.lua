local nvlsp = require "nvchad.configs.lspconfig"
-- load defaults i.e lua_lsp
nvlsp.defaults()
local servers = {
  html = {
    filetypes = {
      "htmlangular",
    },
  },
  cssls = {},
  prismals = {},
  bashls = {},
  angularls = {
    semanticTokens = true,
  },
  ts_ls = {
    init_options = {
      semanticTokens = true,
      preferences = {
        disableSuggestions = false,
        importModuleSpecifierPreference = "absolute",
      },
    },
    semanticTokens = true,
  },
  gopls = {},
  jsonls = {},
  yamlls = {},
  rust_analyzer = {},
  astro = {},
  -- tailwindcss = {},
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  -- opts.capabilities = nvlsp.capabilities

  require("lspconfig")[name].setup(opts)
end

--
-- require("lspconfig").ts_ls.setup {
--   -- on_attach = nvlsp.on_attach,
--   -- capabilities = nvlsp.capabilities,
--   -- on_init = function(client, bufnr)
--   --   nvlsp.on_init(client, bufnr)
--   --   client.server_capabilities.semanticTokensProvider = true
--   -- end,
--   -- init_options = {
--   --   preferences = {
--   --     disableSuggestions = true,
--   --     importModuleSpecifierPreference = "relative",
--   --   },
--   -- },
-- }
