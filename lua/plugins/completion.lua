return {
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "*",

    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
      },
      completion = {
        accept = { auto_brackets = { enabled = false } },
        menu = {
          max_height = 20,
          border = "none",
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
        },
        trigger = {
          show_on_backspace = true,
        },
      },
      signature = {
        enabled = true,
        window = { show_documentation = true },
      },
      keymap = {
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<c-h>"] = { "snippet_backward" },
        ["<c-l>"] = { "snippet_forward" },
      },
      cmdline = {
        keymap = {
          ["<c-y>"] = { "accept", "fallback" },
          ["<c-p>"] = {
            function(cmp) return cmp.select_prev({ auto_insert = false }) end,
            "fallback",
          },
          ["<c-n>"] = {
            function(cmp) return cmp.select_next({ auto_insert = false }) end,
            "fallback",
          },
        },
        completion = {
          menu = { auto_show = true },
        },
      },
      sources = {
        default = { "lazydev", "lsp", "easy-dotnet", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          ["easy-dotnet"] = {
            name = "easy-dotnet",
            enabled = true,
            module = "easy-dotnet.completion.blink",
            score_offset = 10000,
            async = true,
          },
        },
      },
    },
  },

  {
    "cohama/lexima.vim",
    config = function()
      local rule = vim.fn["lexima#add_rule"]

      -- Rules for angle brackets e.g. "List<int>"
      rule({
        char = "<",
        input_after = ">",
        at = [[\w\%#]],
      })
      rule({
        char = ">",
        at = [[\%#>]],
        leave = 1,
      })
      rule({
        char = "<bs>",
        at = [[<\%#>]],
        delete = 1,
      })

      -- Disable space insertion for brackets in markdown files
      rule({
        filetype = "markdown",
        char = " ",
        at = "[\\%#]",
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      aliases = { razor = "html" },
    },
  },
}
