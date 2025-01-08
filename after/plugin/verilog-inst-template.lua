local function multi_arg_str(template, arg)
	return template:gsub("%%s", arg)
end

function verilog_inst(module_name, ...)
	local args = {...}

	local template = multi_arg_str("%s %s_inst\n(\n", module_name)

	for i = 1, #args - 1 do
		local input = args[i]
		template = template .. multi_arg_str("\t.%s(%s_sig) , // input %s_sig\n", input)
	end

	local output = args[#args]

	template = template .. multi_arg_str("\t.%s(%s_sig) , // output %s_sig\n", output)

	template = template .. ");"

	local buf = vim.api.nvim_get_current_buf() -- Get current buffer
  local cursor = vim.api.nvim_win_get_cursor(0) -- Get cursor position (row, col)
  local row = cursor[1] - 1 -- Convert to 0-indexed row

  -- Split the multiline string into individual lines
  local lines = vim.split(template, "\n", { plain = true })

  -- Insert lines at the current cursor position
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
end
