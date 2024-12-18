local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end
treesitter.setup({
  ensure_installed = {
    "lua",
    "rust",
    "javascript",
    "typescript",
    "tsx",
    "css",
    "scss",
    "html",
    "json",
    "jsonc",
    "python",
    "kotlin",
    "jsdoc",
    "markdown",
    "yaml",
    "bash",
    "sql",
    "toml",
    -- "solidity",
    "vim",
    "vimdoc",
    "query",
    "dockerfile",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = { "lua" },
  },
  -- context_commentstring = {
  --   enable = true,
  --   enable_autocmd = false,
  -- },
  -- rainbow = {
  --   enable = true,
  --   disable = { "html" },
  --   extended_mode = false,
  --   max_file_lines = nil,
  -- },
  -- autopairs = { enable = true },
  -- autotag = { enable = true },
  incremental_selection = { enable = true },
  -- indent = { enable = false },
})
