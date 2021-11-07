-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.

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