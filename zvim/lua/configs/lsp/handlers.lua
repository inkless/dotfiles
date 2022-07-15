zvim.lsp = {}
local user_plugin_opts = zvim.user_plugin_opts
local conditional_func = zvim.conditional_func

zvim.lsp.on_attach = function(client, bufnr)
  zvim.set_mappings(
    {
      n = {
        ["K"] = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
        ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" },
        ["<leader>lf"] = { function() vim.lsp.buf.formatting_sync() end, desc = "Format code" },
        ["<leader>lh"] = { function() vim.lsp.buf.signature_help() end, desc = "Signature help" },
        ["<leader>lr"] = { function() vim.lsp.buf.rename() end, desc = "Rename current symbol" },
        ["gD"] = { function() vim.lsp.buf.declaration() end, desc = "Declaration of current symbol" },
        ["gI"] = { function() vim.lsp.buf.implementation() end, desc = "Implementation of current symbol" },
        ["gd"] = { function() vim.lsp.buf.definition() end, desc = "Show the definition of current symbol" },
        ["gr"] = { function() vim.lsp.buf.references() end, desc = "References of current symbol" },
        ["<leader>ld"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        ["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "Previous diagnostic" },
        ["]d"] = { function() vim.diagnostic.goto_next() end, desc = "Next diagnostic" },
        ["gl"] = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
      },
    },
    { buffer = bufnr }
  )

  vim.api.nvim_buf_create_user_command(
    bufnr,
    "Format",
    function() vim.lsp.buf.formatting() end,
    { desc = "Format file with LSP" }
  )

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
    })
  end

  local on_attach_override = user_plugin_opts("lsp.on_attach", nil, false)
  local aerial_avail, aerial = pcall(require, "aerial")
  conditional_func(on_attach_override, true, client, bufnr)
  conditional_func(aerial.on_attach, aerial_avail, client, bufnr)
end

zvim.lsp.capabilities = vim.lsp.protocol.make_client_capabilities()
zvim.lsp.capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
zvim.lsp.capabilities.textDocument.completion.completionItem.snippetSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.preselectSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
zvim.lsp.capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
zvim.lsp.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
zvim.lsp.capabilities = user_plugin_opts("lsp.capabilities", zvim.lsp.capabilities)
zvim.lsp.flags = user_plugin_opts "lsp.flags"

function zvim.lsp.server_settings(server_name)
  local server = require("lspconfig")[server_name]
  local opts = user_plugin_opts(
    "lsp.server-settings." .. server_name,
    user_plugin_opts("lsp.server-settings." .. server_name, {
      capabilities = vim.tbl_deep_extend("force", zvim.lsp.capabilities, server.capabilities or {}),
      flags = vim.tbl_deep_extend("force", zvim.lsp.flags, server.flags or {}),
    }, true, "configs")
  )
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    conditional_func(old_on_attach, true, client, bufnr)
    zvim.lsp.on_attach(client, bufnr)
    conditional_func(user_on_attach, true, client, bufnr)
  end
  return opts
end

function zvim.lsp.disable_formatting(client) client.resolved_capabilities.document_formatting = false end

return zvim.lsp
