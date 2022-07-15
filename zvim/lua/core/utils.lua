_G.zvim = {}
local stdpath = vim.fn.stdpath
local tbl_insert = table.insert
local map = vim.keymap.set

zvim.install = { home = stdpath "config" }
local supported_configs = { zvim.install.home }

local function load_module_file(module)
  local found_module = nil
  for _, config_path in ipairs(supported_configs) do
    local module_path = config_path .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
    if vim.fn.filereadable(module_path) == 1 then found_module = module_path end
  end
  if found_module then
    local status_ok, loaded_module = pcall(require, module)
    if status_ok then
      found_module = loaded_module
    else
      zvim.notify("Error loading " .. found_module, "error")
    end
  end
  return found_module
end

zvim.user_settings = load_module_file "user.init"
zvim.user_terminals = {}

local function func_or_extend(overrides, default, extend)
  if extend then
    if type(overrides) == "table" then
      default = vim.tbl_deep_extend("force", default, overrides)
    elseif type(overrides) == "function" then
      default = overrides(default)
    end
  elseif overrides ~= nil then
    default = overrides
  end
  return default
end

function zvim.conditional_func(func, condition, ...)
  if (condition == nil and true or condition) and type(func) == "function" then return func(...) end
end

function zvim.notify(msg, type, opts)
  vim.notify(msg, type, vim.tbl_deep_extend("force", { title = "zvim" }, opts or {}))
end

function zvim.echo(messages)
  messages = messages or { { "\n" } }
  if type(messages) == "table" then vim.api.nvim_echo(messages, false, {}) end
end

local function user_setting_table(module)
  local settings = zvim.user_settings or {}
  for tbl in string.gmatch(module, "([^%.]+)") do
    settings = settings[tbl]
    if settings == nil then break end
  end
  return settings
end

function zvim.user_plugin_opts(module, default, extend, prefix)
  if extend == nil then extend = true end
  default = default or {}
  local user_settings = load_module_file((prefix or "user") .. "." .. module)
  if user_settings == nil and prefix == nil then user_settings = user_setting_table(module) end
  if user_settings ~= nil then default = func_or_extend(user_settings, default, extend) end
  return default
end

function zvim.url_opener()
  if vim.fn.has "mac" == 1 then
    vim.fn.jobstart({ "open", vim.fn.expand "<cfile>" }, { detach = true })
  elseif vim.fn.has "unix" == 1 then
    vim.fn.jobstart({ "xdg-open", vim.fn.expand "<cfile>" }, { detach = true })
  else
    zvim.notify("gx is not supported on this OS!", "error")
  end
end

-- term_details can be either a string for just a command or
-- a complete table to provide full access to configuration when calling Terminal:new()
function zvim.toggle_term_cmd(term_details)
  if type(term_details) == "string" then term_details = { cmd = term_details, hidden = true } end
  local term_key = term_details.cmd
  if vim.v.count > 0 and term_details.count == nil then
    term_details.count = vim.v.count
    term_key = term_key .. vim.v.count
  end
  if zvim.user_terminals[term_key] == nil then
    zvim.user_terminals[term_key] = require("toggleterm.terminal").Terminal:new(term_details)
  end
  zvim.user_terminals[term_key]:toggle()
end

function zvim.add_cmp_source(source)
  local cmp_avail, cmp = pcall(require, "cmp")
  if cmp_avail then
    local config = cmp.get_config()
    tbl_insert(config.sources, source)
    cmp.setup(config)
  end
end

function zvim.get_user_cmp_source(source)
  source = type(source) == "string" and { name = source } or source
  local priority = zvim.user_plugin_opts("cmp.source_priority", {
    nvim_lsp = 1000,
    luasnip = 750,
    buffer = 500,
    path = 250,
  })[source.name]
  if priority then source.priority = priority end
  return source
end

function zvim.add_user_cmp_source(source) zvim.add_cmp_source(zvim.get_user_cmp_source(source)) end

function zvim.null_ls_providers(filetype)
  local registered = {}
  local sources_avail, sources = pcall(require, "null-ls.sources")
  if sources_avail then
    for _, source in ipairs(sources.get_available(filetype)) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        tbl_insert(registered[method], source.name)
      end
    end
  end
  return registered
end

function zvim.null_ls_sources(filetype, source)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail and zvim.null_ls_providers(filetype)[methods.internal[source]] or {}
end

function zvim.set_mappings(map_table, base)
  for mode, maps in pairs(map_table) do
    for keymap, options in pairs(maps) do
      if options then
        local cmd = options
        if type(options) == "table" then
          cmd = options[1]
          options[1] = nil
        else
          options = {}
        end
        map(mode, keymap, cmd, vim.tbl_deep_extend("force", options, base or {}))
      end
    end
  end
end

return zvim
