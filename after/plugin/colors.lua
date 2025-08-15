function colors_update(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	local dark_grey = "#1c1c1c"

	-- make a reusable bg apply function
	local function set_bg(groups, color)
		for _, grp in ipairs(groups) do
			vim.api.nvim_set_hl(0, grp, { bg = color })
		end
	end

	-- main editor areas
	set_bg({
		"Normal", "NormalNC", "NormalFloat", "FloatBorder", "Folded", "FoldColumn",
		"SignColumn", "LineNr", "CursorLineNr", "EndOfBuffer", "CursorColumn",
		"ColorColumn"
	}, dark_grey)

	-- statuslines & tabs
	set_bg({
		"StatusLine", "StatusLineNC", "TabLine", "TabLineFill", "TabLineSel", "WinSeparator"
	}, dark_grey)

	-- popup menus
	set_bg({
		"Pmenu", "PmenuSbar", "PmenuSel", "PmenuThumb"
	}, dark_grey)

	-- telescope / fuzzy finder
	set_bg({
		"TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal",
		"TelescopePromptBorder", "TelescopeResultsNormal", "TelescopeResultsBorder",
		"TelescopePreviewNormal", "TelescopePreviewBorder"
	}, dark_grey)

	-- LSP & diagnostics windows
	set_bg({
		"DiagnosticFloatingError", "DiagnosticFloatingWarn",
		"DiagnosticFloatingInfo", "DiagnosticFloatingHint",
		"FloatTitle"
	}, dark_grey)
end

colors_update()

