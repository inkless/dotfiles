local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  sources = {
    require("null-ls").builtins.formatting.stylua,
    require("null-ls").builtins.formatting.black.with({
      extra_args = { "-l", "120", "-S" },
    }),
    require("null-ls").builtins.diagnostics.flake8,
    require("null-ls").builtins.diagnostics.markdownlint,
    require("null-ls").builtins.diagnostics.stylelint,
  },
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- vim.lsp.buf.format({ bufnr = bufnr })
          vim.lsp.buf.format({ async = false })
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          -- vim.lsp.buf.formatting_sync()
        end,
      })
    end
  end,
})
