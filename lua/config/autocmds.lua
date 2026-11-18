-- Editor autocmds, loaded by init.lua.

-- Neovim resets 'scroll' to half the window height when its size changes.
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "WinResized" }, {
  group = vim.api.nvim_create_augroup("fixed_scroll_distance", { clear = true }),
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      vim.wo[win].scroll = math.min(vim.g.scroll_lines, vim.api.nvim_win_get_height(win))
    end
  end,
})
