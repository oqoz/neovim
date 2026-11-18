local M = {}

local function project_root()
  local path = vim.api.nvim_buf_get_name(0)
  if vim.bo.filetype == "oil" then
    path = require("oil").get_current_dir() or path
  end
  local cwd = vim.fn.getcwd()
  return vim.fs.root(path ~= "" and path or cwd, ".git") or cwd
end

function M.files()
  require("fzf-lua").files({ cwd = project_root() })
end

function M.live_grep()
  require("fzf-lua").live_grep({ cwd = project_root() })
end

function M.buffers()
  require("fzf-lua").buffers()
end

return M
