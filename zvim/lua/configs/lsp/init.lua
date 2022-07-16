local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then return end

require "configs.lsp.handlers"
local sign_define = vim.fn.sign_define

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}
for _, sign in ipairs(signs) do
  sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
vim.diagnostic.config({
  virtual_text = true,
  signs = { active = signs },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local servers = {}
local installer_avail, lsp_installer = pcall(require, "nvim-lsp-installer")
if installer_avail then
  for _, server in ipairs(lsp_installer.get_installed_servers()) do
    table.insert(servers, server.name)
  end
end

for _, server in ipairs(servers) do
  local opts = zvim.lsp.server_settings(server)
  lspconfig[server].setup(opts)
end
