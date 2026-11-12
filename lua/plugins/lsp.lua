return {
  {
    "saghen/blink.cmp",
    -- v2 is still under active development and requires blink.lib.
    -- Keep the stable v1 behavior that was used before removing LazyVim.
    version = "1.*",
    opts = {
      keymap = {
        preset = "super-tab",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      vim.diagnostic.config({
        virtual_lines = false,
        signs = {
          -- Use the same diagnostic icons as LazyVim, without depending on it.
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
        virtual_text = {
          spacing = 2,
          virt_text_pos = "eol",
          -- Keep source and diagnostic codes in the float, not beside the code.
          prefix = " <-",
          suffix = " ",
          source = false,
        },
        severity_sort = true,
      })

      -- Share completion support with Python and servers installed through Mason.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config("lua_ls", {
        settings = { Lua = {} },
        before_init = function(_, config)
          -- Only Neovim's config workspace needs the vim API definitions.
          local root = config.root_dir
          if not root or vim.uv.fs_realpath(root) ~= vim.uv.fs_realpath(vim.fn.stdpath("config")) then
            return
          end

          config.settings.Lua = vim.tbl_deep_extend("force", config.settings.Lua, {
            runtime = {
              version = "LuaJIT",
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME .. "/lua" },
            },
          })
        end,
      })

      local uvx = vim.fn.exepath("uvx")
      if uvx == "" then
        vim.notify("uvx executable not found; Python LSPs were not enabled", vim.log.levels.WARN)
        return
      end

      vim.lsp.config("ty", {
        cmd = { uvx, "ty", "server" },
        filetypes = { "python" },
        root_markers = {
          "ty.toml",
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".git",
        },
        settings = {
          ty = {
            diagnosticMode = "openFilesOnly",
          },
        },
      })

      vim.lsp.config("ruff", {
        cmd = { uvx, "ruff", "server" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "ruff.toml",
          ".ruff.toml",
          ".git",
        },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
        on_attach = function(client)
          -- ty provides hover information; Ruff still provides diagnostics,
          -- formatting, quick fixes, fix-all, and organize-imports actions.
          client.server_capabilities.hoverProvider = false
        end,
      })

      vim.lsp.enable({
        "ty",
        "ruff",
      })

      -- LazyVim's opts.servers["*"].keys override is no longer needed:
      -- plain nvim-lspconfig does not install LazyVim's insert-mode <C-k> map.
      -- Alternative Python servers are excluded from Mason auto-enable below.
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = { border = "rounded" },
        },
      },
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- Use lspconfig names here to install servers on every machine.
      -- Example: ensure_installed = { "lua_ls", "ts_ls" },
      ensure_installed = {},
      automatic_enable = {
        exclude = {
          -- ty and Ruff are already configured and enabled through uvx above.
          "ty",
          "ruff",
          "ruff_lsp",
          -- Keep the previous choice of ty instead of these Python servers.
          "pyright",
          "basedpyright",
        },
      },
    },
  },
}
