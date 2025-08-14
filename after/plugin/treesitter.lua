local ts_configs = require'nvim-treesitter.configs'
ts_configs.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "go", "c", "javascript", "typescript", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
	textobjects = {
    move = {
      enable = true,
      -- default keymaps can be disabled if you remap them yourself
      set_jumps = true,
    },
  },
}

local ts_move = require("nvim-treesitter.textobjects.move")

vim.keymap.set("n", "]]", function()
  ts_move.goto_next_start("@function.outer")
end)

vim.keymap.set("n", "[[", function()
  ts_move.goto_previous_start("@function.outer")
end)
