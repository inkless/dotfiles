return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/buildkite/pipeline-schema/main/schema.json"] = ".buildkite/*",
            },
            -- schemaStore = {
            --   enable = false, -- Disable automatic schema fetching from schemastore
            --   url = "", -- Set an empty URL to disable schema store
            -- },
            validate = true, -- Enable YAML validation
            hover = true, -- Enable hover information
            completion = true, -- Enable autocompletion
          },
        },
      },
    },
  },
}
