return {
  { "tpope/vim-sleuth" },

  { "hiphish/rainbow-delimiters.nvim" },

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
    end,
  },

  { "numToStr/Comment.nvim", opts = {} },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  {
    "windwp/nvim-ts-autotag",
    config = true,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },
}
