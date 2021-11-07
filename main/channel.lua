-- Channel

local M = {}
	
function M.new()
	return setmetatable({}, { __index = M })
end

function M:register(method_name)
	if self[method_name] == nil then
		self[method_name] = {}
	end
	
	local url = msg.url()
	self[method_name][url] = url
end

function M:unregister(method_name)
	if self[method_name] == nil then
		return
	end
	
	self[method_name][msg.url()] = nil
	
	if #self[method_name] == 0 then -- Если пусто удаляем
		self[method_name] = nil
	end
end

function M:send(method_name, data)
	if self[method_name] == nil then
		return
	end
	
	for key, _ in pairs(self[method_name]) do
		msg.post(key, method_name, data)
	end
end

return M