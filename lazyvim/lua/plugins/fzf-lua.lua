return {
  "ibhagwan/fzf-lua",

  keys = {
    { "<A-x>", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader><space>", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    { "<leader>/", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
  },
}
