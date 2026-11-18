-- Editor defaults, loaded by init.lua before plugin initialization.

local uv_tool_bin = vim.fn.expand("~/.local/bin")
if not vim.env.PATH:find(uv_tool_bin, 1, true) then
  vim.env.PATH = uv_tool_bin .. ":" .. vim.env.PATH
end

if vim.env.ZELLIJ ~= nil then
  vim.g.clipboard = "osc52"
end

-- Use GUI colors for the theme and bufferline.
vim.opt.termguicolors = true

-- Ask before abandoning modified buffers; saving remains an explicit action.
vim.opt.confirm = true
vim.opt.autowrite = false
vim.opt.autowriteall = false

-- Fallback indentation; filetype plugins and EditorConfig can override it.
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1

-- Current line: absolute number. Other lines: distance from the cursor.
vim.opt.number = true
vim.opt.relativenumber = true
-- Cursor line/column fallback; lualine displays these via its location component.
vim.opt.ruler = true

-- Disable Neovim mouse handling in every mode.
vim.opt.mouse = ""

-- Ctrl+d/u distance. Keep the configured value for window resize restoration.
vim.opt.scroll = 6
vim.g.scroll_lines = vim.o.scroll

vim.opt.wrap = true
vim.opt.linebreak = false
vim.opt.breakindent = true
vim.opt.list = true
vim.opt.listchars:append({ trail = "⋅" })
