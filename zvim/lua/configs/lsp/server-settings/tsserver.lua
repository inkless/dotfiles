return {
  on_attach = function (client, bufnr)
    zvim.lsp.disable_formatting(client)

    vim.api.nvim_create_augroup("eslint_fix_on_save", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "EslintFixAll on save",
      buffer = bufnr,
      group = "eslint_fix_on_save",
      -- pattern = "*.tsx,*.ts,*.jsx,*.js,*.mjs,*.cjs",
      command = "EslintFixAll",
    })
  end,
  -- handlers = {
  --   ["textDocument/publishDiagnostics"] = function(_, _, params, client_id, _, config)
  --     if params.diagnostics ~= nil then
  --       local idx = 1
  --       while idx <= #params.diagnostics do
  --         if params.diagnostics[idx].code == 80001 then
  --           table.remove(params.diagnostics, idx)
  --         else
  --           idx = idx + 1
  --         end
  --       end
  --     end
  --     vim.lsp.diagnostic.on_publish_diagnostics(_, _, params, client_id, _, config)
  --   end,
  -- }
}
