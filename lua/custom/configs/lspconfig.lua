local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local function on_attach_override(client, bufnr)
  on_attach(client, bufnr)
  if client.server_capabilities.signatureHelpProvider then
    require("lsp-overloads").setup(client, {
      keymaps = {
        close_signature = "<ESC>"
      }
    })
  end
end

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "omnisharp" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach_override,
    capabilities = capabilities,
  }
end

local pid = vim.fn.getpid()
lspconfig.omnisharp.setup {
  on_attach = on_attach_override,
  capabilities = capabilities,
  cmd = { "C:\\Users\\tgrieger\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\libexec\\OmniSharp.exe", "--languageserver" , "--hostPID", tostring(pid) },
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler
  }
}
