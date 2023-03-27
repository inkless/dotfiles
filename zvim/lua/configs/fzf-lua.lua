local status_ok, fzf_lua = pcall(require, "fzf-lua")
if not status_ok then
  return
end

local is_light = require("configs.colorscheme").is_light
local delta_theme = is_light and "--light" or "--dark"
local delta_pager = "delta --width=$FZF_PREVIEW_COLUMNS " .. delta_theme

fzf_lua.setup({
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<F1>"]        = "toggle-help",
      ["<F2>"]        = "toggle-fullscreen",
      -- Only valid with the 'builtin' previewer
      ["<F3>"]        = "toggle-preview-wrap",
      ["<F4>"]        = "toggle-preview",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["<F6>"]        = "toggle-preview-cw",
      ["<S-down>"]    = "preview-page-down",
      ["<S-up>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["ctrl-u"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["f3"]          = "toggle-preview-wrap",
      ["f4"]          = "toggle-preview",
      ["shift-down"]  = "preview-page-down",
      ["shift-up"]    = "preview-page-up",
    },
  },
  previewers = {
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- uncomment if you wish to use git-delta as pager
      -- can also be set under 'git.status.preview_pager'
      pager           = delta_pager
    },
    builtin = {
      -- Notice!!!
      -- This is causing treesitter not working when loading the actual file
      -- comment it out for now
      treesitter      = { enable = false },
    },
    -- builtin = {
    --   syntax          = true,         -- preview syntax highlight?
    --   syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
    --   syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
    --   limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
    --   -- preview extensions using a custom shell command:
    --   -- for example, use `viu` for image previews
    --   -- will do nothing if `viu` isn't executable
    --   extensions      = {
    --     -- neovim terminal only supports `viu` block output
    --     ["png"]       = { "viu", "-b" },
    --     ["jpg"]       = { "ueberzug" },
    --   },
    --   -- if using `ueberzug` in the above extensions map
    --   -- set the default image scaler, possible scalers:
    --   --   false (none), "crop", "distort", "fit_contain",
    --   --   "contain", "forced_cover", "cover"
    --   -- https://github.com/seebye/ueberzug
    --   ueberzug_scaler = "cover",
    -- },
  },
  git = {
    commits = {
      preview_pager = delta_pager
    },
    bcommits = {
      preview_pager = delta_pager
    },
  },
})
