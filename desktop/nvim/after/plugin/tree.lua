local tree = require("nvim-tree").setup()
vim.keymap.set('n', '<C-n>', vim.cmd.NvimTreeToggle)
vim.keymap.set('n', '</>', vim.cmd.NvimTreeFindFile)
