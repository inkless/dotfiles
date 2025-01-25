-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local create_cmd = vim.api.nvim_create_user_command
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Escape --
map("i", "jk", "<esc>", { desc = "Escape" })
map("t", "jk", "<C-\\><C-n>", { desc = "Escape" })

-- Buffer --
-- map("n", "<leader>br", "<cmd>e!<cr><cmd>redraw<cr>", { desc = "Reload buffer" })

-- Resize window using <ctrl> arrow keys
map("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Git --
map("n", "<leader>go", "<cmd>Git checkout %<cr>", { desc = "Git checkout current file" })
