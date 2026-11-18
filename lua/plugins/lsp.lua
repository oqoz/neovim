return {
  {
    "saghen/blink.cmp",
    -- Keep completion on the stable v1 API.
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
      require("config.diagnostics").setup()

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
          -- Avoid enabling competing Python servers.
          "pyright",
          "basedpyright",
        },
      },
    },
  },
}
