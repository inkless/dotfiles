local create_cmd = vim.api.nvim_create_user_command
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then options = vim.tbl_extend("force", options, opts) end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Escape --
map("i", "jk", "<esc>", { desc = "Escape" })

-- Normal --
-- Standard Operations
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
-- map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>hl", "<cmd>set hlsearch!<cr>", { desc = "No Highlight" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
map("n", "<leader>ob", function() zvim.url_opener() end, { desc = "Open the file under cursor with system app" })
map("n", "<C-s>", "<cmd>w!<cr>", { desc = "Force write" })
-- map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force quit" })
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
map("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Switch buffer" })
map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next buffer tab" })
map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer tab" })

map("n", "<leader>bl", "<c-^>", { desc = "Last buffer" })
map("n", "<leader>br", "<cmd>e!<cr><cmd>redraw<cr>", { desc = "Reload buffer" })
map("n", "<leader>bd", "<cmd>Bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>b]", "<cmd>bnext<cr>", { desc = "Next buffer tab" })
map("n", "<leader>b[", "<cmd>bprevios<cr>", { desc = "Previous buffer tab" })

-- Comment
map("i", "<c-_><c-_>", function() require("Comment.api").toggle.linewise.current(nil) end, { desc = "Comment line" })
map("n", "<c-_><c-_>", function() require("Comment.api").toggle.linewise.current(nil) end, { desc = "Comment line" })
map(
  "v",
  "<c-_><c-_>",
  "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
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
map("n", "<leader>gt", function() require("gitsigns").stage_hunk() end, { desc = "Stage git hunk" })
map("n", "<leader>gU", function() require("gitsigns").undo_stage_hunk() end, { desc = "Unstage git hunk" })
map("n", "<leader>gd", function() require("gitsigns").diffthis() end, { desc = "View git diff" })
-- Other git
map("n", "<leader>gB", "<cmd>GBrowse<cr>", { desc = "Git browse" })
map("n", "<leader>gl", "<cmd>Git blame<cr>", { desc = "Git blame" })
map("n", "<leader>go", "<cmd>Git checkout %<cr>", { desc = "Git checkout current file" })

if vim.g.search_lib == "telescope" then
  -- Telescope
  map("n", "<leader>gf", function() require("telescope.builtin").git_files() end, { desc = "Git files" })
  map("n", "<leader>gs", function() require("telescope.builtin").git_status() end, { desc = "Git status" })
  map("n", "<leader>gb", function() require("telescope.builtin").git_branches() end, { desc = "Git branches" })
  map("n", "<leader>gc", function() require("telescope.builtin").git_bcommits() end, { desc = "Git buffer commits" })
  map("n", "<leader>gC", function() require("telescope.builtin").git_commits() end, { desc = "Git commits" })
end

if vim.g.search_lib == "fzf" then
  map("n", "<leader>gf", function() require("fzf-lua").git_files() end, { desc = "Git files" })
  map("n", "<leader>gs", function() require("fzf-lua").git_status() end, { desc = "Git status" })
  map("n", "<leader>gb", function() require("fzf-lua").git_branches() end, { desc = "Git branches" })
  map("n", "<leader>gc", function() require("fzf-lua").git_bcommits() end, { desc = "Git buffer commits" })
  map("n", "<leader>gC", function() require("fzf-lua").git_commits() end, { desc = "Git commits" })
end

-- NeoTree
map("n", "<leader>op", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })
map("n", "<leader>oe", "<cmd>Neotree focus<cr>", { desc = "Focus Explorer" })
map("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Reveal in Explorer" })

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
map("n", "<A-Up>", function() require("smart-splits").resize_up() end, { desc = "Resize split up" })
map("n", "<A-Down>", function() require("smart-splits").resize_down() end, { desc = "Resize split down" })
map("n", "<A-Left>", function() require("smart-splits").resize_left() end, { desc = "Resize split left" })
map("n", "<A-Right>", function() require("smart-splits").resize_right() end, { desc = "Resize split right" })

-- Telescope

if vim.g.search_lib == "telescope" then
  map("n", "<leader>/", function() require("telescope.builtin").live_grep() end, { desc = "Search words" })
  map("n", "<leader>fw", function() require("telescope.builtin").live_grep() end, { desc = "Search words" })
  map("n", "<leader>fW", function()
    require("telescope.builtin").live_grep({
      additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    })
  end, { desc = "Search words in all files" })
  map("n", "<leader><space>", function() require("telescope.builtin").find_files() end, { desc = "Search files" })
  map(
    "n",
    "<leader>ff",
    function() require("telescope.builtin").find_files({ hidden = true }) end,
    { desc = "Search files (includes hidden)" }
  )
  map("n", "S", function() require("telescope.builtin").grep_string() end, { desc = "Search for word under cursor" })
  map("n", "<leader>fr", function() require("telescope.builtin").oldfiles() end, { desc = "Search recent files" })
  map("n", "<leader>f/d", ":Telescope live_grep cwd=", { desc = "Search words in directory" })
  map("n", "<leader>f/t", ":Telescope live_grep type_filter=", { desc = "Search words by file type" })
  map("n", "<leader>f/g", ":Telescope live_grep glob_pattern=", { desc = "Search words in files with glob pattern" })
  map("n", "<leader>fFa", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", { desc = "Search all files" })
  map("n", "<leader>fFd", ":Telescope find_files cwd=", { desc = "Search files in directory" })
  map("n", "<leader>fFD", ":Telescope find_files search_dirs=", { desc = "Search files in list of directories" })
  map(
    "n",
    "<leader>fFc",
    ":Telescope find_files find_command=rg,--hidden,--files",
    { desc = "Search files by command" }
  )
  map("n", "<leader>f.", function() require("telescope.builtin").resume() end, { desc = "Resume last Search" })
end

if vim.g.search_lib == "fzf" then
  map("n", "<leader>/", function() require("fzf-lua").live_grep_native() end, { desc = "Search words" })
  map("n", "<leader>fw", function() require("fzf-lua").live_grep_native() end, { desc = "Search words" })
  map(
    "n",
    "<leader>fW",
    function()
      require("fzf-lua").live_grep_native({
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden --no-ignore",
      })
    end,
    { desc = "Search words in all files" }
  )
  map("n", "<leader><space>", function() require("fzf-lua").files() end, { desc = "Search files" })
  map("n", "<leader>ff", function() require("fzf-lua").files() end, { desc = "Search files" })
  map("n", "S", function() require("fzf-lua").grep_cword() end, { desc = "Search for word under cursor" })
  map("n", "<leader>fr", function() require("fzf-lua").oldfiles() end, { desc = "Search recent files" })
  map("n", "<leader>f/.", function() require("fzf-lua").live_grep_resume() end, { desc = "Resume last Search" })
  map("n", "<leader>f/d", function()
    local directory = require("fzf-lua.utils").input("Directory❯ ")
    require("fzf-lua").live_grep_native({ cwd = directory })
  end, { desc = "Search words in directory" })
  map("n", "<leader>f/p", function() require("fzf-lua").grep() end, { desc = "Search for a pattern" })
  map(
    "n",
    "<leader>f/g",
    function() require("fzf-lua").live_grep_glob() end,
    { desc = "Search words in files with glob pattern" }
  )
  map(
    "n",
    "<leader>fFa",
    function() require("fzf-lua").files({ rg_opts = "--color=never --files --hidden --no-ignore --follow -g '!.git'" }) end,
    { desc = "Search all files" }
  )
  map("n", "<leader>fFd", function()
    local directory = require("fzf-lua.utils").input("Directory❯ ")
    require("fzf-lua").files({ cwd = directory })
  end, { desc = "Search words in directory" })
  map("n", "<leader>f.", function() require("fzf-lua").resume() end, { desc = "Resume last Search" })
  map("n", "<leader>fz", ":FzfLua ", { desc = "Open fzf-lua" })
end

-- telescope only
map("n", "<leader>fc", function() require("telescope.builtin").commands() end, { desc = "Search commands" })
-- emacs like M-x
map("n", "<A-x>", function() require("telescope.builtin").commands() end, { desc = "Search commands" })
map("n", "<leader>fm", function() require("telescope.builtin").marks() end, { desc = "Search marks" })
map("n", "<leader>fM", function() require("telescope.builtin").man_pages() end, { desc = "Search man" })
map("n", "<leader>fR", function() require("telescope.builtin").registers() end, { desc = "Search registers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Search help" })
map("n", "<leader>fk", function() require("telescope.builtin").keymaps() end, { desc = "Search keymaps" })
map(
  "n",
  "<leader>fN",
  function() require("telescope").extensions.notify.notify() end,
  { desc = "Search notifications" }
)
map("n", "<leader>f/o", "<cmd>Telescope live_grep grep_open_files=true<cr>", { desc = "Search words in open files" })

-- lsp/code related
map("n", "<leader>cs", function()
  local aerial_avail, _ = pcall(require, "aerial")
  if aerial_avail then
    require("telescope").extensions.aerial.aerial()
  else
    require("telescope.builtin").lsp_document_symbols()
  end
end, { desc = "Search symbols" })
map("n", "<leader>co", vim.diagnostic.open_float, { desc = "Open diagnostic window" })
-- SymbolsOutline
map("n", "<leader>cS", "<cmd>AerialToggle<cr>", { desc = "Symbols outline" })

-- lsp lists
if vim.g.lsp_qf_list == "quickfix" then
  map("n", "<leader>cr", function() vim.lsp.buf.references() end, { desc = "Search references" })
  map("n", "<leader>cd", function() vim.lsp.diagnostic.set_qflist() end, { desc = "Search current diagnostics" })
end

if vim.g.lsp_qf_list == "telescope" then
  map("n", "<leader>cr", function() require("telescope.builtin").lsp_references() end, { desc = "Search references" })
  map(
    "n",
    "<leader>cd",
    function() require("telescope.builtin").diagnostics({ bufnr = 0 }) end,
    { desc = "Search current diagnostics" }
  )
  map("n", "<leader>cD", function() require("telescope.builtin").diagnostics() end, { desc = "Search all diagnostics" })
end

if vim.g.lsp_qf_list == "trouble" then
  map("n", "<leader>cr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "Search references" })
  map("n", "<leader>cd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Search current diagnostics" })
  map("n", "<leader>cD", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Search all diagnostics" })
  map("n", "<leader>ot", "<cmd>TroubleToggle<cr>", { desc = "Toggle trouble" })
end

map("n", "<leader>c\\", "<cmd>%s/\\s\\+$//<cr><cmd>let @/=''<cr>", { desc = "Strip trailing whitespaces" })

-- Markdown preview
map("n", "<leader>om", "<Plug>MarkdownPreviewToggle", { desc = "Toggle Markdown preview" })

-- Terminal
-- not really useful... mostly for fun
map("n", "<leader>oT", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
map("n", "<A-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "unindent line" })
map("v", ">", ">gv", { desc = "indent line" })

-- easy align

-- Start interactive EasyAlign in visual mode (e.g. vipga)
map("x", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map("n", "ga", "<Plug>(EasyAlign)", { desc = "EasyAlign" })

-- vim-jsdoc
map("n", "<leader>cc", "<Plug>(jsdoc)", { desc = "Genereate JSDoc" })

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
-- map("n", "<leader>rc", function () require("configs.colorscheme").update() end, { desc = "Reload colorscheme" })

-- tabs
map("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- fold
-- there is an issue with treesitter, remap zi as a workaround
-- https://github.com/nvim-treesitter/nvim-treesitter/issues/1337
map("n", "zi", function()
  vim.wo.foldenable = not vim.wo.foldenable
  vim.wo.foldmethod = "expr"
  map("n", "<tab>", "@=(foldlevel('.') ? 'za' : '<tab>')<CR>", { desc = "Toggle fold", buffer = true, noremap = true })
end, { desc = "Toggle foldenable" })

-- Move lines up/dowk
map("n", "<A-j>", "<cmd>m .+1<cr>==")
map("n", "<A-k>", "<cmd>m .-2<cr>==")
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi")
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi")
vim.cmd([[
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
]])

-- vimux
map("n", "<leader>vo", "<cmd>VimuxOpenRunner<cr><cmd>VimuxInspectRunner<cr>", { desc = "Vimux open runner" })
map("n", "<leader>vp", "<cmd>VimuxPromptCommand<cr>", { desc = "Vimux prompt command" })
map("n", "<leader>vL", "<cmd>VimuxRunLastCommand<cr>", { desc = "Run last command from VimuxRunCommand" })
map(
  "n",
  "<leader>vl",
  function() require("core.vimux").run_last_tmux_cmd() end,
  { desc = "Run last command from tmux" }
)

-- diff related
-- nvimdiff notes
-- ]c :        - next difference
-- [c :        - previous difference
-- do          - diff obtain
-- dp          - diff put
-- za          - toggle folded text
-- :diffupdate - re-scan the files for differences
map("n", "<leader>dd", function()
  if vim.wo.diff then
    vim.cmd([[windo diffoff]])
  else
    vim.cmd([[windo diffthis]])
  end
end, { desc = "Make current tab diff mode" })
map("n", "<leader>dL", "<cmd>%diffget 2<cr>", { desc = "Get all [merge local]/[rebase onto]" })
map("n", "<leader>dl", "<cmd>diffget 2<cr>", { desc = "Get [merge local]/[rebase onto]" })
map("n", "<leader>dR", "<cmd>%diffget 4<cr>", { desc = "Get all [merge remote]/[rebase current]" })
map("n", "<leader>dr", "<cmd>diffget 4<cr>", { desc = "Get [merge remote]/[rebase current]" })
map(
  "n",
  "<leader>do",
  "<cmd>vert new | set bt=nofile | set bh=hide | r ++edit # | 0d_ | diffthis | wincmd p | diffthis<cr>",
  { desc = "Diff original file" }
)

-- dap
-- nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
-- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
-- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
-- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
-- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
-- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
-- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>
map("n", "<F8>", function() require("dap").continue() end, { desc = "Continue" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Step over" })
map("n", "<F11>", function() require("dap").step_into() end, { desc = "Step into" })
map("n", "<S-F11>", function() require("dap").step_out() end, { desc = "Step out" })
map("n", "<leader>Db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map(
  "n",
  "<leader>DB",
  function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
  { desc = "Set breakpoint with condition" }
)
map(
  "n",
  "<leader>Dl",
  function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
  { desc = "Set breakpoint with condition" }
)
map("n", "<leader>Dr", function() require("dap").repl.open() end, { desc = "Open REPL" })
map("n", "<leader>Dl", function() require("dap").run_last() end, { desc = "Run last" })
map("n", "<leader>Do", function() require("dapui").open() end, { desc = "Open DAP UI" })
map("n", "<leader>Dc", function() require("dapui").close() end, { desc = "Close DAP UI" })
map("n", "<leader>Dt", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- Improved Terminal Mappings
-- map("t", "<esc>", "<C-\\><C-n>", { desc = "Terminal normal mode" })
-- map("t", "jk", "<C-\\><C-n>", { desc = "Terminal normal mode" })
-- map("t", "<C-h>", "<c-\\><c-n><c-w>h", { desc = "Terminal left window navigation" })
-- map("t", "<C-j>", "<c-\\><c-n><c-w>j", { desc = "Terminal down window navigation" })
-- map("t", "<C-k>", "<c-\\><c-n><c-w>k", { desc = "Terminal up window navigation" })
-- map("t", "<C-l>", "<c-\\><c-n><c-w>l", { desc = "Terminal right window naviation" })

create_cmd("W", "w", {})
create_cmd("Q", "q", {})
create_cmd("Rg", function(args)
  local rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden "
    .. table.concat(args.fargs, " ")
  require("fzf-lua").live_grep_native({ rg_opts = rg_opts })
end, { desc = "Rg", nargs = "*" })
