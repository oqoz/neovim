-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- EOL            -> $
-- EOL and insert -> A

local keymap = vim.keymap
keymap.set("i", "jj", "<Esc>", { noremap = true })
keymap.set("i", "jk", "<Esc><Cmd>write<CR>", { noremap = true })
keymap.set("i", "<C-h>", "<Left>", { noremap = true })
keymap.set("i", "<C-j>", "<Down>", { noremap = true })
keymap.set("i", "<C-k>", "<Up>", { noremap = true })
keymap.set("i", "<C-l>", "<Right>", { noremap = true })

keymap.set("n", "dw", "bved", { noremap = true })
keymap.set("n", "<C-a>", "gg<S-v>G", { noremap = true })
keymap.set("n", ";", "<Nop>", { noremap = true })
keymap.set("n", "q", "<Nop>", { noremap = true })
keymap.set("n", "m", "<Nop>", { noremap = true })

-- E (Shift+e): show every diagnostic on the current line, including its source.
keymap.set("n", "E", function()
  vim.diagnostic.open_float({ scope = "line", border = "rounded", source = true })
end, { desc = "Show diagnostics for current line" })

-- visual mode settings
keymap.set("x", "q", "<Esc>", { noremap = true })

local indentctrl = require("config.keymap.indentctrl")
keymap.set("x", "<Tab>", indentctrl.indent, { noremap = true })
keymap.set("x", "<S-Tab>", indentctrl.outdent, { noremap = true })
