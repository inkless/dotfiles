local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then return end
gitsigns.setup(zvim.user_plugin_opts("plugins.gitsigns", {
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "▎" },
    topdelete = { text = "契" },
    changedelete = { text = "▎" },
  },
}))
