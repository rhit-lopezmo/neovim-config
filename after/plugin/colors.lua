-- Use the terminal's background color for Neovim surfaces
function colors_use_terminal_bg(color, opts)
  color = color or "catppuccin"
  opts = opts or {}
  local make_floats_transparent = (opts.floats ~= false)  -- default: true

  vim.cmd.colorscheme(color)

  -- Only clear container surfaces (do NOT touch highlight groups)
  local base_groups = {
    -- editor surface
    "Normal", "NormalNC", "NonText", "EndOfBuffer",
    -- gutters / numbers / folds
    "SignColumn", "FoldColumn", "LineNr", "LineNrAbove", "LineNrBelow", "CursorLineNr",
    -- bars / tabs / splits / messages
    "StatusLine", "StatusLineNC", "WinBar", "WinBarNC",
    "TabLine", "TabLineFill", "TabLineSel",
    "VertSplit", "WinSeparator",
    "MsgArea", "MsgSeparator",
  }

  local groups = vim.deepcopy(base_groups)
  if make_floats_transparent then
    -- let hover/diagnostics/Telescope/Harpoon follow terminal bg too
    vim.list_extend(groups, { "NormalFloat", "FloatBorder", "FloatTitle" })
    -- popup menu surface can be transparent; keep PmenuSel intact for contrast
    table.insert(groups, "Pmenu")
    table.insert(groups, "PmenuSbar")
    table.insert(groups, "PmenuThumb")
  end

  local function apply()
    for _, grp in ipairs(groups) do
      pcall(vim.api.nvim_set_hl, 0, grp, { bg = "none", ctermbg = "none" })
    end
  end

  apply()

  -- re-apply on future :colorscheme
  local aug = vim.api.nvim_create_augroup("UseTerminalBG", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = aug, callback = apply })

  -- let the terminal handle the background; keep in-buffer blending off
  vim.o.termguicolors = true
  vim.o.winblend = 0
  vim.o.pumblend = 0
end

-- call it once (floats transparent by default):
colors_use_terminal_bg("catppuccin")
-- or keep floats opaque while the main window uses the terminal bg:
-- colors_use_terminal_bg("catppuccin", { floats = false })

