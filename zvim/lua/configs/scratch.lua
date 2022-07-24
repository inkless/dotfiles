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
-- map("n", "<leader>sI", "<cmd>call scratch#insert(1)<cr>", { desc = "Clear and insert in Scratch file" })
-- map("x", "<leader>si", "<cmd>ScratchSelection<cr>", { desc = "Insert selection to scratch file" })
-- map("x", "<leader>sI", "<cmd>call scratch#selection(1)<cr>", { desc = "Clear and insert selection to scratch file" })
map("n", "<leader>so", "<cmd>Scratch<cr>", { desc = "Open Scratch file" })
map("n", "<leader>sp", "<cmd>ScratchTogglePreview<cr>", { desc = "Toggle Preview Scratch file" })
-- map("n", "<leader>f<c-v>", "<cmd>vnew | set bt=nofile | set bh=hide<cr>", { desc = "Scratch file vertically" })
-- map("n", "<leader>x", "<cmd>bo new | set bt=nofile | set bh=hide<cr><cmd>resize 15<cr>", { desc = "Scratch file in bottom" })
map("n", "<leader>se", "<cmd>ScratchEval<cr>", { desc = "Eval Scratch" })
