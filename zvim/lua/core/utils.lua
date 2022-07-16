_G.zvim = {}

zvim.user_terminals = {}

function zvim.notify(msg, type, opts)
  vim.notify(msg, type, vim.tbl_deep_extend("force", { title = "zvim" }, opts or {}))
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

function zvim.add_cmp_source(source)
  local cmp_avail, cmp = pcall(require, "cmp")
  if cmp_avail then
    local config = cmp.get_config()
    table.insert(config.sources, source)
    cmp.setup(config)
  end
end

function zvim.get_user_cmp_source(source)
  source = type(source) == "string" and { name = source } or source
  local priority = ({
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
        table.insert(registered[method], source.name)
      end
    end
  end
  return registered
end

function zvim.null_ls_sources(filetype, source)
  local methods_avail, methods = pcall(require, "null-ls.methods")
  return methods_avail and zvim.null_ls_providers(filetype)[methods.internal[source]] or {}
end

function zvim.load_module_file(module)
  local found_module = nil
  local module_path = vim.fn.stdpath("config") .. "/lua/" .. module:gsub("%.", "/") .. ".lua"
  if vim.fn.filereadable(module_path) == 1 then
    local status_ok, loaded_module = pcall(require, module)
    if status_ok then
      found_module = loaded_module
    else
      zvim.notify("Error loading " .. found_module, "error")
    end
  end
  return found_module
end

return zvim
