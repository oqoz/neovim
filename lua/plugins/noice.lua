return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      cmdline = {
        view = "cmdline_popup",
      },
      -- Blink owns the completion menu, including command-line completion.
      popupmenu = { enabled = false },
      messages = {
        view = "mini",
        view_error = "mini",
        view_warn = "mini",
      },
      notify = {
        view = "mini",
      },
      -- Keep Neovim's current LSP documentation and diagnostic popups.
      lsp = {
        hover = { enabled = false },
        signature = { enabled = false },
        progress = { enabled = true, view = "mini" },
        message = { enabled = true, view = "mini" },
      },
      presets = {
        bottom_search = true,
        -- This preset moves the command line to the top of the screen.
        command_palette = false,
        -- Send messages of 20 lines or more to a split.
        long_message_to_split = true,
      },
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          border = { style = "rounded" },
        },
        mini = {
          position = { row = -1, col = "100%" },
          timeout = 2000,
        },
      },
    },
    config = function(_, opts)
      -- Compatibility for Noice versions whose setup refers to _on_message
      -- while the actual server-message callback is named on_message.
      -- Set the alias before setup, which initializes asynchronously.
      local message = require("noice.lsp.message")
      if message._on_message == nil and type(message.on_message) == "function" then
        message._on_message = message.on_message
      end

      require("noice").setup(opts)
    end,
  },
}
