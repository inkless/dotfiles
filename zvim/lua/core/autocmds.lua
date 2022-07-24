local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("vim_source", { clear = true })
autocmd("BufWritePost", {
  group = "vim_source",
  pattern = vim.fn.expand('$MYVIMRC'),
  command = "luafile <afile>",
})

-- This need to be done here
augroup("neotree_start", { clear = true })
autocmd("BufEnter", {
  desc = "Open Neo-Tree on startup with directory",
  group = "neotree_start",
  callback = function()
    local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
    if stats and stats.type == "directory" then require("neo-tree.setup.netrw").hijack() end
  end,
})

-- augroup("quickfix_mapping", { clear = true })
-- autocmd("FileType", {
--   group = "quickfix_mapping",
--   pattern = "qf",
--   callback = function ()
--     vim.keymap.set("n", "q", "<cmd>cclose<cr>", { buffer = true })
--   end
-- })

augroup("auto_change_bg", { clear = true })
autocmd("Signal", {
  desc = "Detect signal to change background",
  group = "auto_change_bg",
  pattern = "SIGUSR1",
  callback = function ()
    vim.defer_fn(function ()
      require("configs.colorscheme").update()
    end, 0)
  end
})
