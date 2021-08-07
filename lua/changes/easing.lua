local PI = math.pi
local cos = math.cos
local pow = math.pow
local M = {}

local linear = function(x)
	return x
end

local ease_in_out_sine = function(x)
	return -(cos(PI * x) - 1) / 2
end

local ease_out_cubic = function(x)
	return 1 - pow(1 - x, 3)
end
local ease_in_cubic = function(x)
	return pow(x, 3)
end

-- stylua: ignore
local easing_functions = {
	linear      = linear,
	ease_in     = ease_in_cubic,
	ease_out    = ease_out_cubic,
	ease_in_out = ease_in_out_sine,
}


M.apply_easing_function = function(x)
	local easing_function = easing_functions[(vim.g.footprints_easing_function or "ease_in_out")]
	if easing_function ~= nil then
		easing_function(x)
	else
		error("invalid easing function: " .. vim.g.footprints_easing_function .. " not valid.")
	end
end

return M
