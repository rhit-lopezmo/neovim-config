local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find project files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope find git files' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = 'Telescope search project' })
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope find function symbols in file' })
vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = 'Telescope find function symbols in workspace' })
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'Telescope find references' })
vim.keymap.set('n', '<leader>ph', function()
  require('telescope.builtin').find_files({ hidden = true })
end, { desc = "Find files including hidden files" })

