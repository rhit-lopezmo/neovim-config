vim.keymap.set('n', '<C-_>', function() vim.cmd('normal gcc') end, { desc = 'Commentary comments out a line of code' })
vim.keymap.set('n', '<C-_>', function() vim.cmd('normal gcc') end, { desc = 'Commentary uncomments out a line of code' })
