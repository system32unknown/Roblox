local Table = {}
Table.__index = Table

function Table.has_value(tab, val)
    for _, v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end

function Table.CheckDup(table:table)
	local hash, res = {}, {}
	for _, v in ipairs(table) do
	   	if not hash[v] then
			res[#res + 1] = v
	   	    hash[v] = true
	   	end
	end
	return res
end

return Table