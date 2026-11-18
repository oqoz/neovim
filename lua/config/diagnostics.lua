local M = {}

local virtual_text = {
  spacing = 2,
  virt_text_pos = "eol",
  -- Keep source and diagnostic codes in the float, not beside the code.
  prefix = " <-",
  suffix = " ",
  source = false,
}

function M.setup()
  vim.diagnostic.config({
    -- Keep diagnostics available; only their inline messages start hidden.
    virtual_text = false,
    virtual_lines = false,
    underline = true,
    signs = {
      -- Severity icons and matching line-number highlight groups.
      text = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = " ",
        [vim.diagnostic.severity.HINT] = " ",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
        [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
        [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
        [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
      },
    },
    severity_sort = true,
  })
end

function M.toggle_virtual_text()
  if vim.diagnostic.config().virtual_text then
    vim.diagnostic.config({ virtual_text = false })
  else
    vim.diagnostic.config({ virtual_text = virtual_text })
  end
end

return M
