local Stack = require "previous-buffer.stack"

local buffer_stack = Stack.create()
local buffer_map = {}


local get_buf_expiry_and_update_cache = function(buffer_name)
	local buffer_expiry = nil
	if buffer_map[buffer_name] ~= nil then
		buffer_expiry = buffer_map[buffer_name] + 1
		buffer_map[buffer_name] = buffer_expiry
	else
		buffer_expiry = 1
		buffer_map[buffer_name] = buffer_expiry
	end
	return buffer_expiry
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function(args)
		local buffer_name = vim.api.nvim_buf_get_name(args.buf)

		if #buffer_name ~= 0 and (buffer_stack:is_empty() or buffer_stack:top() ~= buffer_name) then
			local buffer_expiry = get_buf_expiry_and_update_cache(buffer_name)
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


	if buffer_stack:is_empty() then
		local temp_buf_name = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf());

		if #temp_buf_name ~= 0 then
			local temp_buf_expiry = get_buf_expiry_and_update_cache(temp_buf_name)
			buffer_stack:push({ temp_buf_name, temp_buf_expiry })
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
