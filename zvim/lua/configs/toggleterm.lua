local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then return end
toggleterm.setup({
  size = 10,
  open_mapping = [[<A-`>]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
    border = "curved",
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})
