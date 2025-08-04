local Stack = require "stack"

print "Loaded the custom plugin by kj1809"

local file = io.open("output.txt", "w")
if not file then
	print("NO file opened !")
end

-- function split(str, delimiter)
-- 	local result = {}
-- 	for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
-- 		table.insert(result, match)
-- 	end
-- 	return result
-- end

local my_stack = Stack.create()

-- implement later, how to not get neo-tree into the mix
local not_valid = {}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(args)
		local buffer_name = vim.api.nvim_buf_get_name(args.buf)

		if #buffer_name ~= 0 then
			if my_stack:top() ~= buffer_name then
				my_stack:push(buffer_name)
				file:write("Buffer added -> " .. buffer_name .. "\n")

				file:write("Stack : \n")

				for i = 1, my_stack.size do
					file:write(my_stack.arr[i] .. "->")
				end
				file:write("\n-------stack end -----\n")

				file:flush()
			end
		end
	end
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
	callback = function(args)
		file:write("Buffer removed -> " .. vim.api.nvim_buf_get_name(args.buf) .. "\n")
		file:flush()
	end
})


move_to_previous_buffer = function()
	print "Moving to previous buffer"

	if my_stack.size <= 1 then
		print "Nothing to go back to!"
		return
	end

	my_stack:pop()
	local curbuf = my_stack:top();

	local bufnr = vim.fn.bufnr(curbuf)
	print("Buffer " .. bufnr)

	if bufnr ~= -1 then
		vim.cmd("buffer " .. bufnr)
		print "Switched buffer"
	end

	file:write("Stack : \n")

	for i = 1, my_stack.size do
		file:write(my_stack.arr[i] .. "->")
	end
	file:write("\n-------stack end -----\n")

	file:flush()
end




vim.api.nvim_create_user_command("PreviousBuffer", move_to_previous_buffer, {})

-- get the buffer number for the current path and switch to it
-- local bufnr = vim.fn.bufnr("/home/kj1809/Developer/cpp/first.cpp")
--
-- if bufnr ~= -1 then
-- 	vim.cmd("buffer " .. bufnr)
-- end
