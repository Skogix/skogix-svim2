---@module skogix.util
---@author skogix
---@license MIT

-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/init.lua
local LazyUtil = require('lazy.core.util')

local M = {}

local deprecated = {}

setmetatable(M, {
	__index = function(t, k)
		if LazyUtil[k] then
			return LazyUtil[k]
		end
		local dep = deprecated[k]
		if dep then
			local mod = type(dep) == 'table' and dep[1] or dep
			local key = type(dep) == 'table' and dep[2] or k
			M.deprecate(
				[[require("skogix.util").]] .. k,
				[[require("skogix.util").]] .. mod .. '.' .. key
			)
			t[mod] = require('skogix.util.' .. mod) -- load here to prevent loops
			return t[mod][key]
		end
		t[k] = require('skogix.util.' .. k)
		return t[k]
	end,
})

function M.deprecate(old, new)
	M.warn(('`%s` is deprecated. Please use `%s` instead'):format(old, new), {
		title = 'skogix',
		once = true,
		stacktrace = true,
		stacklevel = 6,
	})
end

return M
