if not require("configs.colorscheme").use_themer then
  return
end

local status_ok, themer = pcall(require, "themer")
if not status_ok then
  return
end

themer.setup({
  -- colorscheme = require("configs.colorscheme").colorscheme,
  styles = {
    ["function"] = { style = "italic" },
    functionbuiltin = { style = "italic" },
    variable = { style = "italic" },
    variableBuiltIn = { style = "italic" },
    parameter = { style = "italic" },
  },
  enable_installer = true,
})

require("telescope").load_extension("themes")
