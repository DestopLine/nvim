return {
  "neovim/nvim-lspconfig",

  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",

    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },

    opts = {
      handlers = {
        function(server_name)
          if vim.lsp.config[server_name] then
            vim.lsp.enable(server_name)
          else
            require("lspconfig")[server_name].setup()
          end
        end,
        angularls = function()
          require("lspconfig").angularls.setup({
            filetypes = { "html", "angular" },
          })
        end,
        tailwindcss = function()
          require("lspconfig").tailwindcss.setup({
            filetypes = { "html", "angular" },
            init_options = {
              userLanguages = {
                angular = "html",
              },
            },
          })
        end,
      },
    },
  },

  {
    "seblyng/roslyn.nvim",
    dependencies = {
      "tris203/rzls.nvim",
      "saghen/blink.cmp",
    },
    opts = function()
      return {
        args = {
          "--stdio",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
          "--razorSourceGenerator=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "roslyn",
            "libexec",
            "Microsoft.CodeAnalysis.Razor.Compiler.dll"
          ),
          "--razorDesignTimePath=" .. vim.fs.joinpath(
            vim.fn.stdpath("data") --[[@as string]],
            "mason",
            "packages",
            "rzls",
            "libexec",
            "Targets",
            "Microsoft.NET.Sdk.Razor.DesignTime.targets"
          ),
        },
        ---@diagnostic disable-next-line: missing-fields
        config = {
          handlers = require("rzls.roslyn_handlers"),
          capabilities = require("blink.cmp").get_lsp_capabilities(),
          settings = {},
        },
      }
    end,
  },

  {
    "tris203/rzls.nvim",
    branch = "pullDiags",
    ft = { "cs", "razor" },
    opts = function()
      ---@type rzls.Config
      ---@diagnostic disable-next-line: missing-fields
      return {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      }
    end,
    dependencies = "saghen/blink.cmp",
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      local btins = null_ls.builtins
      null_ls.setup({
        sources = {
          btins.formatting.csharpier,
          btins.formatting.stylua,
          btins.formatting.isort,
          btins.formatting.prettier.with({
            extra_filetypes = { "angular" },
          }),
        },
      })

      vim.keymap.set({ "n", "x" }, "grf", function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local is_null_ls_attached = vim.iter(clients):any(function(client) return client.name == "null-ls" end)
        if is_null_ls_attached then
          vim.lsp.buf.format({ name = "null-ls" })
        else
          vim.lsp.buf.format()
        end
      end, { desc = "Format current buffer" })
    end,
  },

  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
}
