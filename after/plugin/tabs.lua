-- Language-specific settings
vim.cmd [[
  augroup LanguageSpecificTabs
    autocmd!
    " For Python files
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
    " For JavaScript/TypeScript files
    autocmd FileType javascript,typescript setlocal tabstop=4 shiftwidth=4 softtabstop=4
    " For HTML/CSS files
    autocmd FileType html,css,scss setlocal tabstop=4 shiftwidth=4 softtabstop=4
		" For JSON files
		autocmd FileType json setlocal tabstop=4 shiftwidth=4 softtabstop=4
		" For Verilog files
		autocmd FileType verilog setlocal tabstop=4 shiftwidth=4 softtabstop=4
		" For Assembly files
		autocmd FileType asm setlocal tabstop=4 shiftwidth=4 softtabstop=4
	augroup END
]]
