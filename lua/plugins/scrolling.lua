return {
  {
    "folke/snacks.nvim",
    version = "*",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable only scrolling; keep Oil, fzf-lua, and Noice in their current roles.
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 150 },
        },
        animate_repeat = {
          delay = 100,
          duration = { step = 5, total = 50 },
        },
        filter = function(buf)
          if
            vim.g.snacks_scroll == false
            or vim.b[buf].snacks_scroll == false
            or vim.bo[buf].buftype ~= ""
            or vim.bo[buf].filetype == "oil"
          then
            return false
          end

          -- Also exclude ordinary file buffers when shown in a popup/preview.
          for _, win in ipairs(vim.fn.win_findbuf(buf)) do
            if vim.api.nvim_win_get_config(win).relative ~= "" then
              return false
            end
          end
          return true
        end,
      },
    },
  },
}
