-- Util: UI

local M = {}

function M.get_hl(name)
	local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
		or vim.api.nvim_get_hl_by_name(name, true)
	return {
		fg = hl and (hl.fg or hl.foreground),
		bg = hl and (hl.bg or hl.background),
	}
end

function M.bg(name)
	local bg = M.get_hl(name).bg
	return bg and string.format('#%06x', bg) or nil
end

function M.fg(name)
	local fg = M.get_hl(name).fg
	return fg and string.format('#%06x', fg) or nil
end

-- Retrieves color value from highlight group names.
-- First present highlight is returned
function M.get_color(scope, highlights, default)
	for _, hl_name in ipairs(highlights) do
		local hl = vim.api.nvim_get_hl(0, { name = hl_name })
		if hl.reverse then
			if scope == 'bg' then
				scope = 'fg'
			elseif scope == 'fg' then
				scope = 'bg'
			end
		end
		if hl[scope] then
			return string.format('#%06x', hl[scope])
		end
	end
	return default
end

return M
