local status_ok, alpha = pcall(require, "alpha")
if not status_ok then return end

local function button(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      -- hl = "DashboardCenter",
      hl_shortcut = "Keyword",
    },
  }
end

alpha.setup({
  layout = {
    { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
    {
      type = "text",
      val = {
        "███████╗██╗░░░██╗██╗███╗░░░███╗",
        "╚════██║██║░░░██║██║████╗░████║",
        "░░███╔═╝╚██╗░██╔╝██║██╔████╔██║",
        "██╔══╝░░░╚████╔╝░██║██║╚██╔╝██║",
        "███████╗░░╚██╔╝░░██║██║░╚═╝░██║",
        "╚══════╝░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝",
      },
      opts = { position = "center", hl = "Type" },
    },
    { type = "padding", val = 5 },
    {
      type = "group",
      val = {
        button("SPC SPC", "  Find File  "),
        button("SPC /  ", "󰘎  Find Word  "),
        button("SPC f r", "  Recents Files "),
        button("SPC f n", "  New File  "),
        button("SPC f m", "  Bookmarks  "),
        button("SPC S l", "  Last Session  "),
      },
      opts = { spacing = 1 },
    },
  },
  opts = {},
})

local autocmd = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup("alpha_settings", { clear = true })
autocmd("FileType", {
  desc = "Disable tabline for alpha",
  group = "alpha_settings",
  pattern = "alpha",
  callback = function()
    local prev_showtabline = vim.opt.showtabline
    vim.opt.showtabline = 0
    autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function() vim.opt.showtabline = prev_showtabline end,
    })
  end,
})

autocmd("FileType", {
  desc = "Disable statusline for alpha",
  group = "alpha_settings",
  pattern = "alpha",
  callback = function()
    local prev_status = vim.opt.laststatus
    vim.opt.laststatus = 0
    autocmd("BufUnload", {
      pattern = "<buffer>",
      callback = function() vim.opt.laststatus = prev_status end,
    })
  end,
})
