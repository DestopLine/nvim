local function indentation()
  if vim.bo.expandtab then
    return vim.bo.shiftwidth .. " spaces"
  else
    return "tabs"
  end
end

local function line_amount()
  return tostring(vim.fn.line("$")) .. "L"
end

return {
  { "jlcrochet/vim-razor" },

  { "OrangeT/vim-csharp" },

  { "nvim-tree/nvim-web-devicons" },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local tc = require("todo-comments")
      tc.setup({
        signs = false,
      })
      vim.keymap.set("n", "]t", function() tc.jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() tc.jump_prev() end, { desc = "Previous todo comment" })
      vim.keymap.set("n", "<leader>st", vim.cmd.TodoTelescope, { desc = "Search todo comments" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "/", right = "/" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
            symbols = {
              modified = " ",
              readonly = " ",
              newfile = " ",
            },
            fmt = function(s, _) return s:gsub([[\]], "/") end,
          },
        },
        lualine_x = {
          "encoding",
          indentation,
          {
            "fileformat",
            symbols = {
              unix = "unix",
              dos = "dos",
              mac = "mac",
            },
          },
          "filetype",
        },
        lualine_y = {
          line_amount,
          "progress",
        },
        lualine_z = {
          "location",
        },
      },
      inactive_sections = {
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            symbols = {
              modified = " ",
              readonly = " ",
              newfile = " ",
            },
          },
        },
      },
    },
  },
}
