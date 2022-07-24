local status_ok, scratch = pcall(require, "scratch")
if not status_ok then return end

local map = vim.keymap.set

scratch.setup({
  scratch_name = "__Scratch__",
  position = "botright",
  height = 0.2,
})

map("n", "<leader>x", "<cmd>ScratchInsert<cr>", { desc = "Insert in Scratch file" })
map("n", "<leader>si", "<cmd>ScratchInsert<cr>", { desc = "Insert in Scratch file" })
map("n", "<leader>so", "<cmd>Scratch<cr>", { desc = "Open Scratch file" })
map("n", "<leader>sp", "<cmd>ScratchTogglePreview<cr>", { desc = "Toggle Preview Scratch file" })
map("n", "<leader>se", "<cmd>ScratchEval<cr>", { desc = "Eval Scratch" })
