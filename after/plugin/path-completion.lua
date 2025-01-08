-- Map to trigger path completion and remove trailing slash
vim.keymap.set("i", "<C-\\>", "/<C-x><C-f>", { noremap = true, silent = true } )
