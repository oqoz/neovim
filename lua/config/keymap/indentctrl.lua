-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- EOL            -> $
-- EOL and insert -> A

local M = {}

--- @type fun(source: string, pattern: string):integer
local count_prefix = function(source, pattern)
  local count = 0
  for i = 1, source:len() do
    local compare_until = i + pattern:len() - 1
    if source:len() < compare_until or string.match(source:sub(i, compare_until), pattern) == nil then
      break
    end
    count = count + 1
  end
  return count
end

function M.indent()

  local tabstop = vim.bo.tabstop

  local first_line = vim.fn.line("v")
  local last_line = vim.fn.line(".")

  if first_line > last_line then
    first_line, last_line = last_line, first_line
  end

  local lines = vim.api.nvim_buf_get_lines(0, first_line - 1, last_line, false)

  for index, line in ipairs(lines) do
    local existing_spaces_count = count_prefix(line, " ")
    local needed_spaces_count = tabstop - existing_spaces_count % tabstop
    if string.len(line) ~= 0 then
      lines[index] = string.rep(" ", needed_spaces_count) .. line
    end
  end
  vim.api.nvim_buf_set_lines(0, first_line - 1, last_line, false, lines)
end

function M.outdent()
  local tabstop = vim.bo.tabstop

  local first_line = vim.fn.line("v")
  local last_line = vim.fn.line(".")

  if first_line > last_line then
    first_line, last_line = last_line, first_line
  end

  local lines = vim.api.nvim_buf_get_lines(0, first_line - 1, last_line, false)

  local space_removal_valid = true
  for _, line in ipairs(lines) do
    if line:len() ~= 0 and count_prefix(line, " ") < tabstop then
      space_removal_valid = false
      break
    end
  end

  if space_removal_valid then
    for index, line in ipairs(lines) do
      local existing_spaces_count = count_prefix(line, " ")
      if existing_spaces_count < tabstop then
        goto continue
      end
      local space_removal_count = existing_spaces_count % tabstop
      if space_removal_count == 0 and existing_spaces_count ~= 0 then
        space_removal_count = tabstop
      end
      lines[index] = line:sub(space_removal_count + 1)
        ::continue::
    end
    vim.api.nvim_buf_set_lines(0, first_line - 1, last_line, false, lines)
  else
    vim.notify("Outdent formatting is on its limit!!", vim.log.levels.WARN)
  end
end

return M
