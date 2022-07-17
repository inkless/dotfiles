local status_ok, lualine = pcall(require, "lualine")
if not status_ok then return end

lualine.setup({
  options = {
    theme = require("configs.theme").lualine_theme,
  },
  sections = {
    lualine_c = { "filename", "lsp_progress" },
    lualine_x = { 'encoding', 'filetype' },
    lualine_z = { 'location' },
  }
})

vim.api.nvim_create_augroup("lualine_setup", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Reload lualine on colorscheme change",
  group = "lualine_setup",
  callback = function()
    package.loaded["configs.lualine"] = nil
    require "configs.lualine"
  end,
})

