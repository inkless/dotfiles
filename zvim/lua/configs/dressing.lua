local dressing_ok, dressing = pcall(require, "dressing")
if not dressing_ok then return end

dressing.setup()

-- Alternatively, if we need to we could consider use nui to customize it by ourselves
-- https://github.com/MunifTanjim/nui.nvim/wiki/vim.ui#vimuiinput

