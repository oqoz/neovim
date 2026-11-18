return {
  {
    -- multiple cursors
    "brenton-leighton/multiple-cursors.nvim",
    opts = {},
    -- Load on the multiple-cursor binding.
    keys = {
      { "<C-l>", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
    },
  },
}
