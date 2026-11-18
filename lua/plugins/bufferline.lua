local close_buffer = require("config.buffers").close

return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "nvim-mini/mini.bufremove", version = "*", opts = {} },
    },
    opts = {
      options = {
        mode = "buffers",
        separator_style = { "|", "|" },
        diagnostics = false,
        show_close_icon = false,
        close_command = close_buffer,
      },
    },
  },
}
