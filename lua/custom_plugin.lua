local Stack = require "stack"

local buffer_stack = Stack.create()
local buffer_map = {}

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(args)
		local buffer_name = vim.api.nvim_buf_get_name(args.buf)

		if #buffer_name ~= 0 and (buffer_stack:is_empty() or buffer_stack:top() ~= buffer_name) then
			local buffer_expiry = nil
			if buffer_map[buffer_name] ~= nil then
				buffer_expiry = buffer_map[buffer_name] + 1
				buffer_map[buffer_name] = buffer_expiry
			else
				buffer_expiry = 1
				buffer_map[buffer_name] = buffer_expiry
			end

			buffer_stack:push({ buffer_name, buffer_expiry })

		end
	end
})

local get_true_previous_buffer = function()
	-- remove the current buffer
	buffer_stack:pop()

	local prev_buffer = -1

	while not buffer_stack:is_empty() do
		local buf = buffer_stack:top()
		local bufnr = vim.fn.bufnr(buf[1])

		if buffer_map[buf[1]] > buf[2] or bufnr == -1 then
			buffer_stack:pop()
		else
			prev_buffer = bufnr
			break
		end
	end

	return prev_buffer
end


local move_to_previous_buffer = function()
	local prev_buffer = get_true_previous_buffer()

	if prev_buffer == -1 then
		print "Nothing to move back to!"
	else
		vim.cmd("buffer " .. prev_buffer)
	end
end


vim.api.nvim_create_user_command("PreviousBuffer", move_to_previous_buffer, {})

