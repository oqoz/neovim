-- This used to bootstrap LazyVim before the leader keys and options.
-- Keep lazy.nvim initialization in one place below instead.
-- require("config.lazy")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
