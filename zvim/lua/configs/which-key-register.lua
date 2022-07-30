local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end
local mappings = {
  n = {
    ["<leader>"] = {
      f = { name = "Find" },
      ["f."] = { name = "Additional Find" },
      p = { name = "Packer" },
      l = { name = "LSP" },
      c = { name = "Code" },
      g = { name = "Git" },
      S = { name = "Session" },
      o = { name = "Open" },
      b = { name = "Buffer" },
      t = { name = "Test" },
      v = { name = "Vimux" },
      s = { name = "Scratch" },
      ["<tab>"] = { name = "Tab" },
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
