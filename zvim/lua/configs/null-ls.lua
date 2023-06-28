local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

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
})
