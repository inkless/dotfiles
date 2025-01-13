return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
      end,
      desc = "Reveal Explorer NeoTree (cwd)",
    },
    {
      "<leader>op",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
      end,
      desc = "Toggle Explorer NeoTree (cwd)",
    },
  },

  opts = {
    filesystem = {
      -- bind_to_cwd = false,
      -- follow_current_file = { enabled = true },
      -- use_libuv_file_watcher = true,
    },
  },
}
