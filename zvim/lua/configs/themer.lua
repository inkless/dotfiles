local status_ok, themer = pcall(require, "themer")
if not status_ok then return end

themer.setup({
	-- colorscheme = "gruvbox",
	transparent = true,
	styles = {
	  ["function"] = { style = 'italic' },
	  functionbuiltin = { style = 'italic' },
	  variable = { style = 'italic' },
	  variableBuiltIn = { style = 'italic' },
	  parameter  = { style = 'italic' },
	},
})

require("telescope").load_extension("themes")
