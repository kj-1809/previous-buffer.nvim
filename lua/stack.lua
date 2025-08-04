Stack = {
	arr = {},
	size = 0
}

function Stack.create()
	local obj = { arr = {}, size = 0 }
	setmetatable(obj, { __index = Stack })
	return obj
end

function Stack:push(ele)
	table.insert(self.arr, ele)
	self.size = self.size + 1
end

function Stack:pop()
	local val = table.remove(self.arr)
	self.size = self.size - 1
	return val
end

function Stack:top()
	if self:is_empty() then
		return -1
	end
	return self.arr[self.size]
end

function Stack:is_empty()
	if self.size == 0 then
		return true
	end
	return false
end


return Stack
