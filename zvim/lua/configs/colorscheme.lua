local M = {
  colorscheme = "gruvbox",
  dark_theme = "dark",
  light_theme = "light",

  -- if use_background, we don't change colorscheme
  -- just use background to toggle dark or light
  -- otherwise, set dark_theme and light_theme to the desired colorscheme
  use_background = true,

  use_themer = false,
}

local function read_file(path)
  local file = io.open(path, "rb") -- r read mode and b binary mode
  if not file then return nil end
  local content = file:read "*a" -- *a or *all reads the whole file
  file:close()
  return content
end

local function get_theme()
  local theme = read_file(os.getenv("HOME") .. "/.term-theme")
  local is_light = false
  if theme then
    is_light = theme:gsub("%s+", "") == "light"
  end

  return is_light and M.light_theme or M.dark_theme
end

if not M.use_background then
  M.colorscheme = get_theme()
end

function M.update()
  if M.use_background then
    vim.opt.background = get_theme()
  else
    M.colorscheme = get_theme()
  end

  if M.use_themer then
    require("themer").setup({
	    colorscheme = M.colorscheme
    })
  else
    vim.cmd("colorscheme " .. M.colorscheme)
  end
end

function M.initialize()
  M.update()
end

return M
