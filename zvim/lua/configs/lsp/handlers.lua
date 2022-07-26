zvim.lsp = {}

local map = vim.keymap.set
local function get_buf_opts(buffer, desc)
  return { noremap = true, silent = true, buffer = buffer, desc = desc}
end

zvim.lsp.on_attach = function(client, bufnr)
  map("n", "K", function() vim.lsp.buf.hover() end, get_buf_opts(bufnr, "Hover symbol details"))
  map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, get_buf_opts(bufnr, "LSP code action"))
  map("n", "<leader>cf", function() vim.lsp.buf.formatting_sync() end, get_buf_opts(bufnr, "Format code"))
  map("n", "<leader>ch", function() vim.lsp.buf.signature_help() end, get_buf_opts(bufnr, "Signature help"))
  map("n", "<leader>cR", function() vim.lsp.buf.rename() end, get_buf_opts(bufnr, "Rename current symbol"))
  -- I prefer to use gR to rename
  map("n", "gR", function() vim.lsp.buf.rename() end, get_buf_opts(bufnr, "Rename current symbol"))
  map("n", "gI", function() vim.lsp.buf.implementation() end, get_buf_opts(bufnr, "Implementation of current symbol"))
  -- map("n", "<leader>cd", function() vim.diagnostic.open_float() end, get_buf_opts(bufnr, "Hover diagnostics"))
  map("n", "[d", function() vim.diagnostic.goto_prev() end, get_buf_opts(bufnr, "Previous diagnostic"))
  map("n", "]d", function() vim.diagnostic.goto_next() end, get_buf_opts(bufnr, "Next diagnostic"))
  map("n", "gl", function() vim.diagnostic.open_float() end, get_buf_opts(bufnr, "Hover diagnostics"))

  if vim.g.lsp_qf_list == "quickfix" then
    map("n", "gd", function() vim.lsp.buf.definition() end, get_buf_opts(bufnr, "Show the definition of current symbol"))
    map("n", "gD", function() vim.lsp.buf.references() end, get_buf_opts(bufnr, "References of current symbol"))
    -- few lsp servers implemented this
    map("n", "gr", function() vim.lsp.buf.declaration() end, get_buf_opts(bufnr, "Declaration of current symbol"))
  end
  if vim.g.lsp_qf_list == "telescope" then
    map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, get_buf_opts(bufnr, "Show the definition of current symbol"))
    map("n", "gr", function() require("telescope.builtin").lsp_type_definitions() end, get_buf_opts(bufnr, "Declaration of current symbol"))
    map("n", "gD", function() require("telescope.builtin").lsp_references() end, get_buf_opts(bufnr, "References of current symbol"))
  end
  if vim.g.lsp_qf_list == "trouble" then
    -- somehow TroubleToggle lsp_definitions does not work...
    map("n", "gd", function() require("telescope.builtin").lsp_definitions() end, get_buf_opts(bufnr, "Show the definition of current symbol"))
    map("n", "gD", "<cmd>TroubleToggle lsp_references<cr>", get_buf_opts(bufnr, "References of current symbol"))
    map("n", "gr", "<cmd>TroubleToggle lsp_type_definitions<cr>", get_buf_opts(bufnr, "References of current symbol"))
  end

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

  local aerial_avail, aerial = pcall(require, "aerial")
  if aerial_avail then
    aerial.on_attach(client, bufnr)
  end

  local lsp_sig_avail, lsp_signature = pcall(require, "lsp_signature")
  if lsp_sig_avail then
    lsp_signature.on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded",
      }
    })
  end
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
zvim.lsp.flags = {}

function zvim.lsp.server_settings(server_name)
  local server = require("lspconfig")[server_name]

  local opts = zvim.load_module_file("configs.lsp.server-settings." .. server_name) or {}
  opts = vim.tbl_deep_extend("force", opts, {
    capabilities = vim.tbl_deep_extend("force", zvim.lsp.capabilities, server.capabilities or {}),
    flags = vim.tbl_deep_extend("force", zvim.lsp.flags, server.flags or {}),
  })

  local opts_on_attach = opts.on_attach
  opts.on_attach = function(client, bufnr)
    if type(server.on_attach) == "function" then
      server.on_attach(client, bufnr)
    end

    zvim.lsp.on_attach(client, bufnr)

    if type(opts_on_attach) == "function" then
      opts_on_attach(client, bufnr)
    end
  end
  return opts
end

function zvim.lsp.disable_formatting(client) client.resolved_capabilities.document_formatting = false end

return zvim.lsp
