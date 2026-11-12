return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo" },
    -- Mason adds installed formatters such as StyLua to Neovim's PATH.
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
        python = { "ruff_format" },
        lua = { "stylua" },
      },
      -- Run synchronously before an explicit save so the saved file is formatted.
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = "fallback",
      },
      formatters = {
        ruff_format = {
          -- Reuse the existing uvx tool instead of installing a second Ruff.
          command = "uvx",
          prepend_args = { "ruff" },
        },
      },
    },
  },
}
