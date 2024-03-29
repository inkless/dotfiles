local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then return end
neotree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_diagnostics = false,
  default_component_configs = {
    -- indent = {
    --   padding = 0,
    --   with_expanders = false,
    -- },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      default = "",
    },
    git_status = {
      symbols = {
        added = "",
        deleted = "",
        modified = "",
        renamed = "➜",
        untracked = "★",
        ignored = "◌",
        unstaged = "✗",
        staged = "✓",
        conflict = "",
      },
    },
  },
  window = {
    width = 30,
    -- mappings = {
    --   ["S"] = "open_split",
    --   ["s"] = "open_vsplit",
    --   ["t"] = "open_tabnew",
    -- },
  },
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = true,
      hide_gitignored = true,
      hide_by_name = {
        ".DS_Store",
        "thumbs.db",
        "node_modules",
        "__pycache__",
      },
    },
    -- follow_current_file = {
    --   enabled = false, -- This will find and focus the file in the active buffer every time
    --   --               -- the current file is changed while the tree is open.
    --   leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    -- },
    -- hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
    window = {
      mappings = {
        ["/"] = "",
        ["u"] = "navigate_up",
        ["<c-c>"] = "clear_filter",
        ["f"] = "fuzzy_finder",
        ["F"] = "filter_on_submit",
        ["D"] = "fuzzy_finder_directory",
      },
    },
  },
  -- git_status = {
  --   window = {
  --     position = "float",
  --   },
  -- },
  -- event_handlers = {
  --   { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  -- },
})
