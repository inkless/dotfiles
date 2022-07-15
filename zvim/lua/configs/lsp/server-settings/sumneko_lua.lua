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
          [zvim.install.home .. "/lua"] = true,
        },
      },
    },
  },
}
