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
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local installer_avail, mason_lspconfig = pcall(require, "mason-lspconfig")
if installer_avail then
  mason_lspconfig.setup_handlers({
    function (server_name)
      local opts = zvim.lsp.server_settings(server_name)
      lspconfig[server_name].setup(opts)
    end
  })
end
