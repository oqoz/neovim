return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        -- floats = "transparent",
      },
    },
    config = function(_, opts)
      -- require("solarized-osaka").setup(opts)
      -- vim.cmd.colorscheme("solarized-osaka")
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
  },
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    opts = {
      style = "auto", -- this automatically loads colorscheme depending on system theme
      transparent = true,
      line_nr_column_background = false,
      sign_column_background = false,
      on_highlights = function(highlights, colors)
        local diagnostics = {
          Error = { fg = colors.error, bg = colors.bg_red_nuanced },
          Warn = { fg = colors.warning, bg = colors.bg_yellow_nuanced },
          Info = { fg = colors.info, bg = colors.bg_cyan_nuanced },
          Hint = { fg = colors.hint, bg = colors.bg_cyan_nuanced },
        }

        for severity, style in pairs(diagnostics) do
          highlights["DiagnosticLineNr" .. severity] = {
            fg = style.fg,
          }
          highlights["DiagnosticVirtualText" .. severity] = {
            fg = style.fg,
            bg = style.bg,
            bold = false,
          }
        end
      end,
    },
    config = function(_, opts)
      require("modus-themes").setup(opts)
      vim.cmd.colorscheme("modus")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      extensions = { "lazy", "mason" },
    },
  },
}
