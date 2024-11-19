local status_ok, which_key = pcall(require, "which-key")
if not status_ok then return end

which_key.add({
  { "<leader><tab>", group = "Tab" },
  { "<leader>D", group = "DAP" },
  { "<leader>S", group = "Session" },
  { "<leader>b", group = "Buffer" },
  { "<leader>c", group = "Code" },
  { "<leader>d", group = "Diff" },
  { "<leader>f", group = "Find" },
  { "<leader>f/", group = "Advanced Find Word" },
  { "<leader>fF", group = "Advanced Find files" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>o", group = "Open" },
  { "<leader>p", group = "Packer" },
  { "<leader>s", group = "Scratch" },
  { "<leader>t", group = "Test" },
  { "<leader>v", group = "Vimux" },
})
