-- Broadcast
-- Использую __index для перехвата обращения к элементам таблицы.
-- Можно наплодить каналов что будут висеть в памяти. Это минус.
-- Я думаю стоит сделать создание и удаление канала отдельно. Или метод remove_unused для чистки от пустых каналов.

local channel = require "main.channel"

local M = {}

M.channels = {}

function M:__index(name)
	if self.channels[name] == nil then
		self.channels[name] = channel.new()
	end
	return self.channels[name]
end

return setmetatable(M, M) -- Думаю так правильно?