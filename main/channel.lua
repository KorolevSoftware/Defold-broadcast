-- Channel
-- Для каждому  метода создаю новую таблицу, url храню как ключ и как дату. Дата не важна, можно хоть 1 туда сохранить. 
-- Ключ в виду URL нужен для предотвращения повторной подписи на один и тот же метод.
-- При отписке от метода если он не будет содержать подписчиков, то его можно удалить.
-- При вызове проверяем на наличие существования этого метода в таблице.
-- Можно сделать так, чтобы возвращать successful, если отправили хоть кому-то и not в противном случае.

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
	
	if #self[method_name] == 0 then -- Если пуст удаляем
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