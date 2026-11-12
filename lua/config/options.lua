-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- load python lang servers
vim.g.lazyvim_python_lsp = "ty"
vim.g.lazyvim_python_ruff = "ruff"

local uv_tool_bin = vim.fn.expand("~/.local/bin")
if not vim.env.PATH:find(uv_tool_bin, 1, true) then
  vim.env.PATH = uv_tool_bin .. ":" .. vim.env.PATH
end

if vim.env.ZELLIJ ~= nil then
  vim.g.clipboard = "osc52"
end

-- disable trouble in lualine
vim.g.trouble_lualine = false

-- vim options
-- Ask before abandoning modified buffers; saving remains an explicit action.
vim.opt.confirm = true
vim.opt.autowrite = false
vim.opt.autowriteall = false

-- Backspace removes spaces one at a time, not an indentation step.
vim.opt.smarttab = false
vim.opt.softtabstop = 0

-- Current line: absolute number. Other lines: distance from the cursor.
vim.opt.number = true
vim.opt.relativenumber = true
-- Cursor line/column fallback; lualine displays these via its location component.
vim.opt.ruler = true

-- Minimum non-zero mouse-wheel movement per event (lines / columns).
vim.opt.mousescroll = "ver:1,hor:1"

vim.opt.wrap = true
vim.opt.linebreak = false
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars:append({ trail = "⋅" })
