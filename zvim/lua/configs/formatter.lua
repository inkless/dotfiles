local status_ok, formatter = pcall(require, "formatter")
if not status_ok then return end

local exclude_auto_format_folders = { "workspace/web%-ux" }
local black_special_args = { "workspace/all%-the%-things" }
local support_patterns = { "*.py", "*.lua", "*.js", "*.cjs", "*.mjs", "*.ts", "*.jsx", "*.tsx" }

local function is_in_folders(folders)
  for _, v in pairs(folders) do
    if string.find(vim.api.nvim_buf_get_name(0), v) ~= nil then return true end
  end
  return false
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,
    },

    python = {
      function()
        local args = { "-q", "-" }
        if is_in_folders(black_special_args) then args = { "-l", "120", "-S", "-q", "-" } end

        return {
          exe = "black",
          args = args,
          stdin = true,
        }
      end,
    },

    javascript = {
      require("formatter.filetypes.javascript").prettier,
    },

    javascriptreact = {
      require("formatter.filetypes.javascriptreact").prettier,
    },

    typescript = {
      require("formatter.filetypes.typescript").prettier,
    },

    typescriptreact = {
      require("formatter.filetypes.typescriptreact").prettier,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    -- ["*"] = {
    --   -- "formatter.filetypes.any" defines default configurations for any
    --   -- filetype
    --   require("formatter.filetypes.any").remove_trailing_whitespace,
    -- },
  },
})

local format_group = vim.api.nvim_create_augroup("Formatter", { clear = true })

local auto_group = vim.api.nvim_create_augroup("auto_format", { clear = true })
vim.api.nvim_clear_autocmds({ group = auto_group })
vim.api.nvim_create_autocmd("BufRead", {
  desc = "setup auto format",
  group = auto_group,
  pattern = support_patterns,
  callback = function()
    if not is_in_folders(exclude_auto_format_folders) then
      local bufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePost", {
        desc = "Format with formatter",
        group = format_group,
        buffer = bufnr,
        command = "FormatWrite",
      })
    end
  end,
})
