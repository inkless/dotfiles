local augroup = vim.api.nvim_create_augroup("eslint_fix_on_save", {})

return {
  on_attach = function(_, bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "EslintFixAll on save",
      group = augroup,
      buffer = bufnr,
      -- pattern = "*.tsx,*.ts,*.jsx,*.js,*.mjs,*.cjs",
      command = "EslintFixAll",
    })

    vim.keymap.set(
      "n",
      "<leader>cf",
      "<cmd>EslintFixAll<cr>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Eslint Fix All" }
    )
  end,
}
