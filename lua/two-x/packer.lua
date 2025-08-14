-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- use {
	-- 	'olimorris/onedarkpro.nvim',
	-- 	as = 'onedark',
	-- 	config = function()
	-- 		vim.cmd('colorscheme onedark_vivid')
	-- 	end
	-- }

	use {
		'catppuccin/nvim',
		as = 'catppuccin',
		config = function()
			vim.cmd('colorscheme catppuccin')
		end
	}

	use { 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} }
	use { 'nvim-treesitter/nvim-treesitter-textobjects' }
	use { 'nvim-treesitter/playground' }

	use({'neovim/nvim-lspconfig'})
	use({'hrsh7th/nvim-cmp'})
	use({'hrsh7th/cmp-nvim-lsp'})

	use { 'tpope/vim-commentary' }

	use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
	}

	use { 'aklt/plantuml-syntax' }  -- Syntax highlighting
	use { 'weirongxu/plantuml-previewer.vim', requires = { 'tyru/open-browser.vim' } }  -- Previewer
	use { 'tmux-plugins/vim-tmux-focus-events' }

	use { 'mfussenegger/nvim-dap' }
	use { 'leoluz/nvim-dap-go' }
	use { 'nvim-neotest/nvim-nio' }
	use { 'rcarriga/nvim-dap-ui' }

--	use { 'preservim/nerdtree' }
end)
