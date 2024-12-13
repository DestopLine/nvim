return {
  { "tpope/vim-sleuth" },

  { "hiphish/rainbow-delimiters.nvim" },

  { "jiangmiao/auto-pairs" },

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
