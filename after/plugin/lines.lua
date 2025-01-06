-- Move a line up or down
vim.keymap.set('n', '<A-k>', ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set('n', '<A-j>', ":m .+1<CR>==", { desc = "Move line down" })

-- Copy the current line up or down
vim.keymap.set('n', '<A-S-k>', "yypk==", { desc = "Copy current line up", silent = true })
vim.keymap.set('n', '<A-S-j>', "yyp==", { desc = "Copy current line down", silent = true })

-- Move selected lines up or down
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Move selected lines up", silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Move selected lines down", silent = true })

-- Copy selected lines up or down
-- vim.keymap.set('v', '<A-S-j>', ":<C-u>y<CR>`>p`[V`]=gv", { desc = "Copy selected lines down", silent = true })
-- vim.keymap.set('v', '<A-S-k>', ":<C-u>y<CR>`<P`[V`]=gv", { desc = "Copy selected lines up", silent = true })
