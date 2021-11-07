-- Broadcast
-- Использую __index для перехвата обращения к элементам которых нет в таблице.
-- Можно наплодить каналов что будут висеть в памяти. Это минус.
-- Я думаю стоит сделать создание и удаление канала отдельно. Или метод remove_unused для чистки от пустых каналов.

local channel = require "main.channel"

local M = {}

function M:__index(name)
	self[name] = channel.new()
	return self[name]
end

return setmetatable(M, M) -- Думаю так правильно?