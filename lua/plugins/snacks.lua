return {
  "folke/snacks.nvim",
  priority = 1001,
  lazy = false,

  keys = {
    { "<leader>nd", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },

  config = function()
    -- This stops luals from throwing warnings
    Snacks = require("snacks")

    vim.api.nvim_create_user_command("Q", function(cmd_opts) Snacks.bufdelete({ force = cmd_opts.bang }) end, {
      desc = "Delete the current buffer without closing the current window",
      bang = true,
    })

    Snacks.setup({
      bigfile = { enabled = true },
      bufdelete = { enabled = true },

      dashboard = {
        enabled = true,
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = " ", key = "-", desc = "Oil", action = ":Oil" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      input = {
        enabled = true,
        win = {
          style = "input",
          keys = {
            i_cc = { "<c-c>", { "cmp_close", "cancel" }, mode = "i" },
            i_esc = { "<esc>", "stopinsert", mode = "i" },
          },
        },
      },

      notifier = { enabled = true },

      scroll = {
        enabled = true,
        animate = {
          fps = 60,
          duration = {
            step = 10,
            total = 150,
          },
          easing = "inOutCubic",
        },
        filter = function(buf)
          -- Neogit Log View scrolling gets glitchy with this plugin enabled
          return not vim.endswith(vim.api.nvim_buf_get_name(buf), "NeogitLogView")
        end
      },
    })
  end,
}
