-- Keymaps and input handling, loaded by init.lua after plugin registration.

local keymap = vim.keymap

-- Ignore mouse events even if a terminal multiplexer still forwards them.
vim.on_key(function(key, typed)
  local event = vim.fn.keytrans(typed and typed ~= "" and typed or key)
  if
    event:sub(1, 1) == "<"
    and (
      event:find("Mouse", 1, true)
      or event:find("Drag", 1, true)
      or event:find("Release", 1, true)
      or event:find("ScrollWheel", 1, true)
    )
  then
    return ""
  end
end, vim.api.nvim_create_namespace("disabled_mouse_input"))

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

keymap.set("n", "<leader>e", function()
  require("oil").toggle_float()
end, { desc = "Toggle Oil explorer" })

-- Follow the buffer order shown in the bufferline.
keymap.set("n", "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bd", require("config.buffers").close, { desc = "Close buffer (keep windows)" })

local finder = require("config.finder")
keymap.set("n", "<leader><space>", finder.files, { desc = "Find files" })
keymap.set("n", "<leader>/", finder.live_grep, { desc = "Search project contents" })
keymap.set("n", "<leader>,", finder.buffers, { desc = "Find open buffers" })

-- Oil overrides ;; locally to toggle hidden files instead.
keymap.set("n", ";;", require("config.diagnostics").toggle_virtual_text, { desc = "Toggle diagnostic messages" })

-- E (Shift+e): show every diagnostic on the current line, including its source.
keymap.set("n", "E", function()
  vim.diagnostic.open_float({ scope = "line", border = "rounded", source = true })
end, { desc = "Show diagnostics for current line" })

-- Visual-mode keys.
keymap.set("x", "q", "<Esc>", { noremap = true })

-- Native indent honors shiftwidth, expandtab, and project/filetype settings.
keymap.set("x", "<Tab>", ">gv", { noremap = true, desc = "Indent selection" })
keymap.set("x", "<S-Tab>", "<gv", { noremap = true, desc = "Outdent selection" })
