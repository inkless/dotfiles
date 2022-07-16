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
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

alpha.setup({
  layout = {
    { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) } },
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
      opts = { position = "center", hl = "DashboardHeader" },
    },
    { type = "padding", val = 5 },
    {
      type = "group",
      val = {
        button("SPC /", "  Find Word  "),
        button("SPC SPC", "  Find File  "),
        button("SPC f r", "  Recents Files "),
        button("SPC f n", "  New File  "),
        button("SPC f m", "  Bookmarks  "),
        button("SPC S l", "  Last Session  "),
      },
      opts = { spacing = 1 },
    },
  },
  opts = {},
})
