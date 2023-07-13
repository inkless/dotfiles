local plugins = {
  -- Plugin manager
  "wbthomason/packer.nvim",

  -- Optimiser
  "lewis6991/impatient.nvim",

  -- Lua functions
  "nvim-lua/plenary.nvim",

  -- Popup API
  "nvim-lua/popup.nvim",

  -- Color Theme
  -- "sainnhe/gruvbox-material", -- bad for jsx/tsx
  -- "christianchiarulli/nvcode-color-schemes.vim", - bad for jsx/tsx
  "projekt0n/github-nvim-theme", -- not bad, but covered by themer
  -- "rose-pine/neovim", - not bad, but covered by themer
  {
    "ellisonleao/gruvbox.nvim",
    commit = "29c50f1327d9d84436e484aac362d2fa6bca590b",
  },
  {
    "themercorp/themer.lua",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function() require("configs.themer") end,
  },

  -- Indent detection
  {
    "Darazaki/indent-o-matic",
    event = "BufReadPost",
    config = function() require("configs.indent-o-matic") end,
  },

  -- Notification Enhancer
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function() require("configs.notify") end,
  },

  -- Neovim UI Enhancer
  {
    "MunifTanjim/nui.nvim",
    module = "nui",
  },

  {
    "stevearc/dressing.nvim",
    config = function() require("configs.dressing") end,
  },

  -- Cursorhold fix
  {
    "antoinemadec/FixCursorHold.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function() vim.g.cursorhold_updatetime = 100 end,
  },

  -- Tmux navigator
  "christoomey/vim-tmux-navigator",

  -- Smarter Splits
  {
    "mrjones2014/smart-splits.nvim",
    module = "smart-splits",
    config = function() require("configs.smart-splits") end,
  },

  -- Icons
  {
    "kyazdani42/nvim-web-devicons",
    event = "VimEnter",
    config = function() require("configs.icons") end,
  },

  -- tabline
  {
    "alvarosevilla95/luatab.nvim",
    config = function() require("luatab").setup() end,
  },

  -- Better buffer closing
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
  },

  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    module = "neo-tree",
    cmd = "Neotree",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    setup = function() vim.g.neo_tree_remove_legacy_commands = true end,
    config = function() require("configs.neo-tree") end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = function() require("configs.lualine") end,
  },
  "arkav/lualine-lsp-progress",

  -- Parenthesis highlighting
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter",
  },

  -- Autoclose tags
  {
    "windwp/nvim-ts-autotag",
    after = "nvim-treesitter",
  },

  -- Context based commenting
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = { "BufRead", "BufNewFile" },
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    config = function() require("configs.treesitter") end,
  },

  -- Snippet collection
  {
    "rafamadriz/friendly-snippets",
    opt = true,
  },

  -- Snippet engine
  {
    "L3MON4D3/LuaSnip",
    module = "luasnip",
    wants = "friendly-snippets",
    config = function() require("configs.luasnip") end,
  },

  -- Completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function() require("configs.cmp") end,
  },

  -- Snippet completion source
  {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
    config = function() zvim.add_user_cmp_source("luasnip") end,
  },

  -- Buffer completion source
  {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
    config = function() zvim.add_user_cmp_source("buffer") end,
  },

  -- Path completion source
  {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
    config = function() zvim.add_user_cmp_source("path") end,
  },

  -- LSP completion source
  {
    "hrsh7th/cmp-nvim-lsp",
    after = "nvim-cmp",
    config = function() zvim.add_user_cmp_source("nvim_lsp") end,
  },

  -- Built-in LSP
  {
    "neovim/nvim-lspconfig",
    event = "VimEnter",
  },

  -- LSP manager
  {
    "williamboman/mason.nvim",
    run = ":MasonUpdate", -- :MasonUpdate updates registry contents
  },

  {
    "williamboman/mason-lspconfig.nvim",
    requires = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      require("configs.mason")
      require("configs.mason-lspconfig")
      require("configs.lsp")
    end,
  },

  -- LSP signature
  "ray-x/lsp_signature.nvim",

  -- LSP symbols
  -- Aerial is deprecated in neovim<8
  --[[ { ]]
  --[[   "stevearc/aerial.nvim", ]]
  --[[   module = "aerial", ]]
  --[[   cmd = { "AerialToggle", "AerialOpen", "AerialInfo" }, ]]
  --[[   config = function() require "configs.aerial" end, ]]
  --[[ }, ]]

  -- Formatting and linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function() require("configs.null-ls") end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.1",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("configs.telescope") end,
  },

  -- Fuzzy finder syntax support
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  },

  -- FZF
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function() require("configs.fzf-lua") end,
  },

  -- Git integration
  "tpope/vim-fugitive", -- Git wrapper
  "tpope/vim-rhubarb", -- Github extension for vim fugitive
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    config = function() require("configs.gitsigns") end,
  },

  -- Start screen
  {
    "goolord/alpha-nvim",
    after = "nvim-web-devicons",
    -- config = function ()
    --   require'alpha'.setup(require'alpha.themes.dashboard'.config)
    -- end
    config = function() require("configs.alpha") end,
  },

  -- Color highlighting
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function() require("configs.colorizer") end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("configs.autopairs") end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    module = { "toggleterm", "toggleterm.terminal" },
    config = function() require("configs.toggleterm") end,
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    module = { "Comment", "Comment.api" },
    keys = { "gc", "gb", "g<", "g>" },
    config = function() require("configs.Comment") end,
  },

  -- Indentation
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function() require("configs.indent-line") end,
  },

  -- Keymaps popup
  {
    "folke/which-key.nvim",
    module = "which-key",
    config = function() require("configs.which-key") end,
  },

  -- Get extra JSON schemas
  {
    "b0o/SchemaStore.nvim",
    module = "schemastore",
  },

  -- Session manager
  {
    "Shatur/neovim-session-manager",
    module = "session_manager",
    cmd = "SessionManager",
    event = "BufWritePost",
    config = function() require("configs.session_manager") end,
  },

  -- Vim Surround
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- "tpope/vim-surround",
  -- "tpope/vim-repeat",

  -- multi cursor
  "mg979/vim-visual-multi",

  -- easy align
  "junegunn/vim-easy-align",

  -- markdown preview
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

  -- vimux
  "preservim/vimux",

  -- run test
  {
    "inkless/vim-test",
    requires = { "preservim/vimux" },
    config = function() require("configs.vim-test") end,
  },

  -- jsdoc
  {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    run = "make install",
  },

  -- emmet
  "mattn/emmet-vim",

  -- better quickfix
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- scratch
  {
    "~/workspace/scratch.nvim",
    requires = { "preservim/vimux" },
    config = function() require("configs.scratch") end,
  },

  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("configs.trouble") end,
  },

  -- dap
  "mfussenegger/nvim-dap",
  {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function() require("configs.dapui") end,
  },

  -- github copilot
  -- "github/copilot.vim",

  {
    "LunarVim/bigfile.nvim",
  },
}

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd("packadd packer.nvim")

local status_ok, packer = pcall(require, "packer")

if not status_ok then return end

packer.init({
  auto_clean = true,
  compile_on_sync = true,
  git = { clone_timeout = 6000 },
  display = {
    open_fn = function() return require("packer.util").float({ border = "rounded" }) end,
  },
})

packer.startup(function(use)
  for _, plugin in pairs(plugins) do
    use(plugin)
  end

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then packer.sync() end
end)
