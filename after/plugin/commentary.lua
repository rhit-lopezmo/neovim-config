vim.keymap.set('n', '<C-/>', function() vim.cmd('normal gcc') end, { desc = 'Commentary comments out a line of code' })
vim.keymap.set('n', '<C-/>', function() vim.cmd('normal gcc') end, { desc = 'Commentary uncomments out a line of code' })
vim.keymap.set('i', '<C-/>', function() vim.cmd('normal gcc') end, { desc = 'Commentary comments out a line of code' })
vim.keymap.set('i', '<C-/>', function() vim.cmd('normal gcc') end, { desc = 'Commentary uncomments out a line of code' })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "verilog",
    callback = function()
        vim.bo.commentstring = "//%s"
    end,
})
