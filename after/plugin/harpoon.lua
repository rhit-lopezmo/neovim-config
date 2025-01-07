local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
	print(string.format("added '%s' to harpoon !", vim.fn.expand('%:t')))
end)

vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>H", function()
	local harpoon_lists = harpoon.lists
	local current_dir = vim.fn.getcwd() -- Get the current directory

	-- Clear all Harpoon marks for the current directory
	if harpoon_lists[current_dir] and harpoon_lists[current_dir].__harpoon_files then
		harpoon_lists[current_dir].__harpoon_files:clear()
		print("cleared harpoon !")
	else
		print("No Harpoon marks found for the current directory.")
	end
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<", function() harpoon:list():prev() end)
vim.keymap.set("n", ">", function() harpoon:list():next() end)
