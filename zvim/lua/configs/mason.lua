local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

mason.setup({
  log = vim.log.levels.DEBUG,
  ui = {
    icons = {
      package_installed = "✓",
      package_uninstalled = "✗",
      package_pending = "⟳",
    },
  },
  ensure_installed = { "lua-language-server", "typescript-language-server", "eslint-lsp", "pyright" },
})
