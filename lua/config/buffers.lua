local M = {}

function M.close(bufnr)
  bufnr = (bufnr == nil or bufnr == 0) and vim.api.nvim_get_current_buf() or bufnr
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local force = false
  if vim.bo[bufnr].modified then
    local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":~:.")
    local choice =
      vim.fn.confirm('Save changes to "' .. (name ~= "" and name or "[No Name]") .. '"?', "&Yes\n&No\n&Cancel", 3)
    if choice == 1 then
      local ok, err = pcall(vim.api.nvim_buf_call, bufnr, function()
        vim.cmd.write()
      end)
      if not ok then
        vim.notify(tostring(err), vim.log.levels.ERROR)
        return
      end
      -- Some custom write handlers finish asynchronously. Never discard those edits.
      if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].modified then
        vim.notify("Buffer still has unsaved changes; not closed", vim.log.levels.WARN)
        return
      end
    elseif choice == 2 then
      force = true
    else
      return
    end
  end

  if vim.api.nvim_buf_is_valid(bufnr) then
    return require("mini.bufremove").delete(bufnr, force)
  end
end

return M
