-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Filetype defaults (e.g. Python/Rust) can re-enable grouped space deletion.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("single_space_backspace", { clear = true }),
  callback = function(event)
    vim.bo[event.buf].softtabstop = 0
    vim.bo[event.buf].varsofttabstop = ""
  end,
})

--
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "kanagawa",
--   callback = function()
--     if vim.o.background == "light" then
--       vim.fn.system("kitty +kitten themes Kanagawa_light")
--     elseif vim.o.background == "dark" then
--       vim.fn.system("kitty +kitten themes Kanagawa_dragon")
--     else
--       vim.fn.system("kitty +kitten themes Kanagawa")
--     end
--   end,
-- })
