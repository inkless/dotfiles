local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end
local mappings = {
  n = {
    ["<leader>"] = {
      f = { name = "File" },
      p = { name = "Packer" },
      l = { name = "LSP" },
      s = { name = "Search" },
      g = { name = "Git" },
      S = { name = "Session" },
      o = { name = "Open" },
    },
  },
}

for mode, prefixes in pairs(mappings) do
  for prefix, mapping_table in pairs(prefixes) do
    which_key.register(mapping_table, {
      mode = mode,
      prefix = prefix,
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = true,
    })
  end
end
