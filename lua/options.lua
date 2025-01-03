vim.g.omni_sql_no_default_maps = true

vim.opt.hlsearch = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true

vim.opt.mouse = "a"

vim.opt.cursorline = true

vim.opt.scrolloff = 8

vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect"

vim.opt.termguicolors = true

vim.opt.showmode = false

vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = [[nvim – %{fnamemodify(getcwd(), ':t')}/%t]]

vim.opt.splitright = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext = ""

vim.cmd[[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]]
