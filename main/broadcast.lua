-- broadcast

local channel = require "main.channel"

local M = {}

M.channels = {}

function M:__index(name)
	if self.channels[name] == nil then
		self.channels[name] = channel.new()
	end
	return self.channels[name]
end

return setmetatable(M, M)