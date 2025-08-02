print "Hello world from nvim plugin"

local file = io.open("output.txt", "w")
if not file then
	print("NO file opened !")
end

vim.api.nvim_create_autocmd({"BufEnter"}, {
	callback = function(args)
		file:write("Buffer added " .. vim.api.nvim_buf_get_name(args.buf) .. "\n")
		file:write(args.event)
		file:write("end\n")
		file:flush()
	end
})

vim.api.nvim_create_autocmd({"BufLeave"}, {
	callback = function(args)
		file:write("Buffer left " .. vim.api.nvim_buf_get_name(args.buf) .. "\n")
		file:flush()
	end
})

