return {
  {
    "stevearc/oil.nvim",
    version = "*",
    -- Directory buffers must be handled even when starting with `nvim .`.
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = false },
      float = { border = "rounded" },
      keymaps = {
        [";;"] = { "actions.toggle_hidden", mode = "n" },
      },
      -- Apply filesystem edits only after an explicit save and confirmation.
      skip_confirm_for_simple_edits = false,
      lsp_file_methods = { autosave_changes = false },
    },
  },
}
