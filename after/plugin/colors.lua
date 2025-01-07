function colors_update(color)
	color = color or "onedark_vivid"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "@variable", { fg = "#D0D0D0" })  -- Set the variable color to grey
	vim.api.nvim_set_hl(0, "@parameter", { fg = "#D0D0D0" })  -- Set the parameter color to grey
	vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "#D0D0D0" })  -- Set the variable parameter color to grey
	vim.api.nvim_set_hl(0, "Comment", { fg = "#101010", italic = true })  -- Set the comment color to dark grey
	vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#E5E500" })  
	vim.api.nvim_set_hl(0, "@odp.punctuation.bracket.javascript", { fg = "#E5E500" }) 
	vim.api.nvim_set_hl(0, "@odp.punctuation.bracket.python", { fg = "#E5E500" }) 
	vim.api.nvim_set_hl(0, "@function.builtin.asm", { fg = "#61afef" })
	vim.api.nvim_set_hl(0, "@label", { fg = "#89ca78" })
	vim.api.nvim_set_hl(0, "@variable.builtin.asm", { fg = "#F0F0F0" })  -- Set the variable color to grey
	vim.api.nvim_set_hl(0, "@markup.heading", { fg = "#F0F0F0" })  -- Set the variable color to grey
end

colors_update()
