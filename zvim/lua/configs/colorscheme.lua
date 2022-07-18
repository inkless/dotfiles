local M = {}

M.colorscheme = "gruvbox"

local function read_file(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read "*a" -- *a or *all reads the whole file
  file:close()
  return content
end

function M.change_background()
  local theme = read_file(os.getenv("HOME") .. "/.term-theme")
  if not theme then
    return
  end

  local is_light = theme:gsub("%s+", "") == "light"
  vim.opt.background = is_light and "light" or "dark"

  -- local colorscheme = is_dark and "themer_gruvbox" or "themer_ayu"
end

function M.initialize()
  M.change_background()
  pcall(vim.cmd, "colorscheme " .. M.colorscheme)
end

return M
