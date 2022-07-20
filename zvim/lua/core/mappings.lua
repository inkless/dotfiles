local create_cmd = vim.api.nvim_create_user_command
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

map("", "<Space>", "<Nop>")

-- Escape --
map("i", "jk", "<esc>", { desc = "Escape"})

-- Normal --
-- Standard Operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
-- map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "No Highlight" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>ob", function() zvim.url_opener() end, { desc = "Open the file under cursor with system app" })
map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
map("n", "Q", "<Nop>")
map("n", "q:", "<Nop>")

-- Packer
map("n", "<leader>pl", "<cmd>luafile %<cr><cmd>PackerCompile<cr>", { desc = "Source luafile and Packer Compile" })
map("n", "<leader>pc", "<cmd>PackerCompile<cr>", { desc = "Packer Compile" })
map("n", "<leader>pi", "<cmd>PackerInstall<cr>", { desc = "Packer Install" })
map("n", "<leader>ps", "<cmd>PackerSync<cr>", { desc = "Packer Sync" })
map("n", "<leader>pS", "<cmd>PackerStatus<cr>", { desc = "Packer Status" })
map("n", "<leader>pu", "<cmd>PackerUpdate<cr>", { desc = "Packer Update" })

-- Alpha
map("n", "<leader>oa", "<cmd>Alpha<cr>", { desc = "Alpha Dashboard" })

-- Buffer
map("n", "<leader>`", "<c-^>", { desc = "Last buffer" })
map("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Switch buffer" })
map("n", "<S-Right>", "<cmd>bnext<cr>", { desc = "Next buffer tab" })
map("n", "<S-Left>", "<cmd>bprevios<cr>", { desc = "Previous buffer tab" })

map("n", "<leader>bl", "<c-^>", { desc = "Last buffer" })
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Switch buffer" })
map("n", "<leader>br", "<cmd>e!<cr><cmd>redraw<cr>", { desc = "Reload buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>b]", "<cmd>bnext<cr>", { desc = "Next buffer tab" })
map("n", "<leader>b[", "<cmd>bprevios<cr>", { desc = "Previous buffer tab" })

-- Comment
map("i", "<c-_><c-_>", function() require("Comment.api").toggle_current_linewise() end, { desc = "Comment line" })
map("n", "<c-_><c-_>", function() require("Comment.api").toggle_current_linewise() end, { desc = "Comment line" })
map(
  "v",
  "<c-_><c-_>",
  "<esc><cmd>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<cr>",
  { desc = "Toggle comment line" }
)

-- Git
-- GitSigns
map("n", "<leader>gj", function() require("gitsigns").next_hunk() end, { desc = "Next git hunk" })
map("n", "<leader>gk", function() require("gitsigns").prev_hunk() end, { desc = "Previous git hunk" })
map("n", "<leader>gl", function() require("gitsigns").blame_line() end, { desc = "View git blame" })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Preview git hunk" })
map("n", "<leader>gh", function() require("gitsigns").reset_hunk() end, { desc = "Reset git hunk" })
map("n", "<leader>gr", function() require("gitsigns").reset_buffer() end, { desc = "Reset git buffer" })
map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "Stage git hunk" })
map("n", "<leader>gu", function() require("gitsigns").undo_stage_hunk() end, { desc = "Unstage git hunk" })
map("n", "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "View git diff" })
-- Other git
map("n", "<leader>gb", "<cmd>GBrowse<cr>", { desc = "Git browse" })
map("n", "<leader>gl", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>go", "<cmd>Git checkout %<cr>", { desc = "Git checkout current file" })

-- NeoTree
map("n", "<leader>oe", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
map("n", "<leader>e", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })

-- Session Manager
map("n", "<leader>Sl", "<cmd>SessionManager! load_last_session<cr>", { desc = "Load last session" })
map("n", "<leader>Ss", "<cmd>SessionManager! save_current_session<cr>", { desc = "Save this session" })
map("n", "<leader>Sd", "<cmd>SessionManager! delete_session<cr>", { desc = "Delete session" })
map("n", "<leader>Sf", "<cmd>SessionManager! load_session<cr>", { desc = "Search sessions" })
map("n", "<leader>S.", "<cmd>SessionManager! load_current_dir_session<cr>", { desc = "Load current directory session" })

-- LSP Installer
map("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP information" })
map("n", "<leader>lI", "<cmd>LspInstallInfo<cr>", { desc = "LSP installer" })

-- Smart Splits
map("n", "<A-k>", function() require("smart-splits").resize_up() end, { desc = "Resize split up" })
map("n", "<A-j>", function() require("smart-splits").resize_down() end, { desc = "Resize split down" })
map("n", "<A-h>", function() require("smart-splits").resize_left() end, { desc = "Resize split left" })
map("n", "<A-l>", function() require("smart-splits").resize_right() end, { desc = "Resize split right" })

-- SymbolsOutline
map("n", "<leader>lS", "<cmd>AerialToggle<cr>", { desc = "Symbols outline" })

-- Telescope
map("n", "<leader>/", function() require("telescope.builtin").live_grep() end, { desc = "Search words" })
map("n", "<leader>fW",
  function()
    require("telescope.builtin").live_grep {
      additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end
    }
  end,
  { desc = "Search words in all files" }
)
-- map("n", "<leader>gt", function() require("telescope.builtin").git_status() end, { desc = "Git status" })
-- map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Git branches" })
-- map("n", "<leader>gc", function() require("telescope.builtin").git_commits() end, { desc = "Git commits" })
map("n", "<leader><space>", function() require("telescope.builtin").find_files() end, { desc = "Search files" })
map("n", "<leader>fF",
  function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
  { desc = "Search all files" }
)
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Search buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Search help" })
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Search keymaps" })
map("n", "<leader>fc", function() require("telescope.builtin").commands() end, { desc = "Search commands" })
map("n", "<leader>fm", function() require("telescope.builtin").marks() end, { desc = "Search marks" })
map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Search recent files" })
map("n", "S", function() require("telescope.builtin").grep_string() end, { desc = "Search for word under cursor" })
map("n", "<leader>sb", function() require("telescope.builtin").git_branches() end, { desc = "Git branches" })
map("n", "<leader>sh", function() require("telescope.builtin").help_tags() end, { desc = "Search help" })
map("n", "<leader>sm", function() require("telescope.builtin").man_pages() end, { desc = "Search man" })
map("n", "<leader>sn", function() require("telescope").extensions.notify.notify() end, { desc = "Search notifications" })
map("n", "<leader>sr", function() require("telescope.builtin").registers() end, { desc = "Search registers" })
map("n", "<leader>sk", function() require("telescope.builtin").keymaps() end, { desc = "Search keymaps" })
map("n", "<leader>sc", function() require("telescope.builtin").commands() end, { desc = "Search commands" })
map("n", "<leader>ls",
  function()
    local aerial_avail, _ = pcall(require, "aerial")
    if aerial_avail then
      require("telescope").extensions.aerial.aerial()
    else
      require("telescope.builtin").lsp_document_symbols()
    end
  end,
  { desc = "Search symbols" }
)
map("n", "<leader>lR", function() require("telescope.builtin").lsp_references() end, { desc = "Search references" })
map("n", "<leader>lD", function() require("telescope.builtin").diagnostics() end, { desc = "Search diagnostics" })

-- Markdown preview
map("n", "<leader>om", "<Plug>MarkdownPreviewToggle", { desc = "Toggle Markdown preview" })

-- Terminal
-- not really useful... mostly for fun
map("n", "<leader>ot", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- easy align

-- Start interactive EasyAlign in visual mode (e.g. vipga)
map("x", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map("n", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })

-- vim-jsdoc
map("n", "<localleader>d", "<Plug>(jsdoc)", { desc = "Genereate JSDoc" })

-- Allow run macro in multi lines
-- https://github.com/stoeffel/.dotfiles/blob/master/vim/visual-at.vim
vim.cmd([[
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
]])

-- reload colorscheme
map("n", "<leader>rc", function () require("configs.colorscheme").update() end, { desc = "Reload colorscheme" })

-- tabs
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })


-- Move lines up/dowk
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
vim.cmd([[
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
]])


-- Improved Terminal Mappings
map("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Terminal normal mode" })
map("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Terminal left window navigation" })
map("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Terminal down window navigation" })
map("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Terminal up window navigation" })
map("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Terminal right window naviation" })


create_cmd("W", "w", {})
create_cmd("Q", "q", {})
