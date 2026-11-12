return {
  {
    "nvim-mini/mini.pairs",
    version = "*",
    event = "InsertEnter",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)

      -- Rust uses ' for lifetimes as well as character literals.
      local function rust_quotes(bufnr)
        vim.keymap.set("i", "'", "'", {
          buffer = bufnr,
          desc = "Insert Rust lifetime or character quote",
        })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("editing_rust_pairs", { clear = true }),
        pattern = "rust",
        callback = function(event)
          rust_quotes(event.buf)
        end,
      })

      -- InsertEnter can load this plugin after the buffer's FileType event.
      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].filetype == "rust" then
          rust_quotes(bufnr)
        end
      end
    end,
  },
}
