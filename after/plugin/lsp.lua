-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'no'

require("mason").setup()
require("mason-lspconfig").setup()

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- Load langauge servers in here
-- TypeScript/JavaScript language server
require('lspconfig').ts_ls.setup({
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "html" },
})
require('lspconfig').pylsp.setup({})
require('lspconfig').lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }
			}
		}
	}
})
require('lspconfig').html.setup({
	init_options = {
		embeddedLanguages = {
      javascript = true,
      typescript = true,
    },
	}
})
require('lspconfig').cssls.setup({})
require('lspconfig').css_variables.setup({})
require('lspconfig').emmet_ls.setup({
	capabilities = lspconfig_defaults.capabilities,
	filetypes = { "eruby", "html", "javascript", "javascriptreact", "less", "svelte", "pug", "typescriptreact", "vue" },
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	}
})
require('lspconfig').gopls.setup({})

require('lspconfig').clangd.setup({
    cmd = { "clangd" },
    filetypes = { "cpp", "objc", "objcpp" },
    root_dir = require('lspconfig').util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})

require('lspconfig').hdl_checker.setup({})

-- Autocompletion
local cmp = require('cmp')

cmp.setup({
  sources = {
		{name = 'nvim_lsp'},
		{name = 'path'},      -- Path completions
  },
  mapping = cmp.mapping.preset.insert({
    -- Navigate between completion items
    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Tab>'] = cmp.mapping.select_next_item({behavior = 'select'}),

    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Scroll up and down in the completion documentation
    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
    ['<C-k>'] = cmp.mapping.scroll_docs(4),
  }),
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

vim.keymap.set('n', '<leader>qf', function() vim.lsp.buf.code_action() end)
