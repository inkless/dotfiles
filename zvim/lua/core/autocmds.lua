local is_available = zvim.is_available
local cmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("vim_source", { clear = true })
cmd("BufWritePost", {
  group = "vim_source",
  pattern = vim.fn.expand('$MYVIMRC'),
  command = "luafile <afile>",
})

if is_available "alpha-nvim" then
  augroup("alpha_settings", { clear = true })
  if is_available "bufferline.nvim" then
    cmd("FileType", {
      desc = "Disable tabline for alpha",
      group = "alpha_settings",
      pattern = "alpha",
      callback = function()
        local prev_showtabline = vim.opt.showtabline
        vim.opt.showtabline = 0
        cmd("BufUnload", {
          pattern = "<buffer>",
          callback = function() vim.opt.showtabline = prev_showtabline end,
        })
      end,
    })
  end
  cmd("FileType", {
    desc = "Disable statusline for alpha",
    group = "alpha_settings",
    pattern = "alpha",
    callback = function()
      local prev_status = vim.opt.laststatus
      vim.opt.laststatus = 0
      cmd("BufUnload", {
        pattern = "<buffer>",
        callback = function() vim.opt.laststatus = prev_status end,
      })
    end,
  })
end

if is_available "neo-tree.nvim" then
  augroup("neotree_start", { clear = true })
  cmd("BufEnter", {
    desc = "Open Neo-Tree on startup with directory",
    group = "neotree_start",
    callback = function()
      local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
      if stats and stats.type == "directory" then require("neo-tree.setup.netrw").hijack() end
    end,
  })
end

if is_available "lualine.nvim" then
  augroup("lualine_setup", { clear = true })
  cmd("ColorScheme", {
    desc = "Reload lualine on colorscheme change",
    group = "lualine_setup",
    callback = function()
      package.loaded["configs.lualine"] = nil
      require "configs.lualine"
    end,
  })
end
