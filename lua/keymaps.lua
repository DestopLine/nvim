vim.keymap.set("v", "<leader>P", '"_dP', { desc = "Put keep reg" })

-- Copy to and paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Move code :)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Visual block mode fix
vim.keymap.set("i", "<C-c>", "<esc>")

-- Disable "Type  :qa  and press <Enter> to exit Nvim" text
vim.cmd([[nnoremap <C-c> <silent> <C-c>]])

vim.keymap.set({ "n", "v" }, "Z", "zz", { desc = "Center this line" })

-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Quickfix list navigation
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { desc = "Previous quickfix list item" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix list item" })

-- Ctrl backspace as ctrl w in insert mode
vim.keymap.set("i", "<c-bs>", "<c-w>", { desc = "Delete word" })
