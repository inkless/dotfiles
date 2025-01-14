local map = vim.keymap.set
local notify = require("core.utils").notify

vim.g["test#strategy"] = "vimux"
vim.g["test#python#runner"] = "nose"
vim.g["test#python#nose#options"] = "-v --nocapture"
vim.g["test#javascript#jest#executable"] = "npx jest"

local function test_with_watch(nearest, debug)
  if vim.fn.filereadable("node_modules/.bin/jest") == 1 then
    local executable = "npx jest --runInBand --watch"
    if debug then executable = "node --inspect-brk node_modules/.bin/jest --runInBand --no-cache --watch" end

    vim.g["test#javascript#jest#executable"] = executable
    if nearest then
      vim.cmd("TestNearest")
    else
      vim.cmd("TestFile")
    end
    vim.g["test#javascript#jest#executable"] = nil
    return
  end

  notify("Test file watch not supported", "error")
end

map("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest", noremap = true })
map("n", "<leader>tf", "<cmd>TestFile<cr>", { desc = "Test file", noremap = true })
map("n", "<leader>ts", "<cmd>TestSuite<cr>", { desc = "Test suite", noremap = true })
map("n", "<leader>tl", "<cmd>TestLast<cr>", { desc = "Test last", noremap = true })

map("n", "<leader>tF", function() test_with_watch(false, false) end, { desc = "Test file with watch", noremap = true })

map(
  "n",
  "<leader>tN",
  function() test_with_watch(true, false) end,
  { desc = "Test nearest with watch", noremap = true }
)

map("n", "<leader>td", function() test_with_watch(false, true) end, { desc = "Debug file with watch", noremap = true })

map(
  "n",
  "<leader>tD",
  function() test_with_watch(true, true) end,
  { desc = "Debug nearest with watch", noremap = true }
)
