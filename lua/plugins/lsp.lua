---@class (exact) NvimConfig.LanguageServer
---@field settings? table
---@field enabled? boolean
---@field filetypes? string[]
---@field init_options? table

---@module "snacks"

local on_lsp_attach = function(_, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  map("i", "<c-.>", vim.lsp.buf.code_action, "Code action")
  map("n", "<c-k>", vim.lsp.buf.signature_help, "Signature documentation")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

  map("n", "gd", Snacks.picker.lsp_definitions, "Go to definition")
  map("n", "grr", Snacks.picker.lsp_references, "Go to references")
  map("n", "gri", Snacks.picker.lsp_implementations, "Go to implementation")
  map("n", "gC", Snacks.picker.lsp_type_definitions, "Search type definitions")
  map("n", "gO", Snacks.picker.lsp_symbols, "Search document symbols")
  map("n", "gW", Snacks.picker.lsp_workspace_symbols, "Search workspace symbols")
end

return {
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
      "saghen/blink.cmp",
    },

    config = function()
      ---@type { [string]: NvimConfig.LanguageServer }
      local servers = {
        rust_analyzer = { enabled = Utils.is_profile("home") },
        ts_ls = {},
        html = {},
        angularls = {
          enabled = Utils.is_profile("home"),
          filetypes = { "html", "angular" },
        },
        tailwindcss = {
          filetypes = { "html", "angular" },
          init_options = {
            userLanguages = {
              angular = "html",
            },
          },
        },
        jsonls = {},
        clangd = { enabled = Utils.is_profile("home") },
        pyright = {},
        ruff = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        },
      }

      for name, server in pairs(servers) do
        if server.enabled == false then
          servers[name] = nil
        end
      end

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          local server = servers[server_name]

          if server == nil then
            return
          end

          require("lspconfig")[server_name].setup({
            capabilities = require("blink.cmp").get_lsp_capabilities(),
            on_attach = on_lsp_attach,
            settings = server.settings or {},
            filetypes = server.filetypes,
            init_options = server.init_options,
          })
        end,
      })
    end,
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
          on_attach = on_lsp_attach,
          settings = {},
        },
      }
    end,
  },

  {
    "tris203/rzls.nvim",
    ft = { "cs", "razor" },
    opts = function()
      ---@type rzls.Config
      return {
        on_attach = on_lsp_attach,
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
    "stefanboca/venv-selector.nvim",
    branch = "sb/push-rlpxsqmllxtz",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
}
