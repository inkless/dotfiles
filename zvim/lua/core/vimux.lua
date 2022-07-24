local fn = vim.fn
local send_keys = vim.fn.VimuxSendKeys

local M = {}

function M.has_runner(index)
  return fn.match(fn.system("tmux list-panes -F '#{pane_id}'"), index)
end

function M.get_nearest_tmux_index()
  local views = fn.split(fn.system("tmux list-panes -F '#{pane_active}:#{pane_id}'"), "\n")
  for _, v in ipairs(views) do
    if fn.match(v, '1:') == -1 then
      return fn.split(v, ':')[2]
    end
  end

  return -1
end

function M.run_last_tmux_cmd()
  if not vim.g.VimuxRunnerIndex or M.has_runner(vim.g.VimuxRunnerIndex) == -1 then
    local nearest_index = M.get_nearest_tmux_index()
    if nearest_index == -1 then
      require("core.utils").notify("No tmux exists", "error")
    end
    vim.g.VimuxRunnerIndex = nearest_index
  end

  -- q C-u
  send_keys(vim.g.VimuxResetSequence)
  send_keys("Up Enter")
end

return M
