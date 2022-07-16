local stdpath = vim.fn.stdpath

return {
  on_attach = zvim.lsp.disable_formatting,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}
