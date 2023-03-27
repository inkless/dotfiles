return {
  on_attach = function(_, bufnr)
    vim.api.nvim_create_augroup("eslint_fix_on_save", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = "EslintFixAll on save",
      buffer = bufnr,
      group = "eslint_fix_on_save",
      -- pattern = "*.tsx,*.ts,*.jsx,*.js,*.mjs,*.cjs",
      command = "EslintFixAll",
    })

    vim.keymap.set(
      "n",
      "<leader>ce",
      "<cmd>EslintFixAll<cr>",
      { noremap = true, silent = true, buffer = bufnr, desc = "Eslint Fix All" }
    )
  end,
}
