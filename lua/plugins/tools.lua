if false then
  -- make this 'false' only if needed
  return {}
end

return {
  {
    -- multiple cursors
    "brenton-leighton/multiple-cursors.nvim",
    opts = {},
    -- keymaps are declared in keymaps.lua
    keys = {
      { "<C-l>", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
    },
  },
}
