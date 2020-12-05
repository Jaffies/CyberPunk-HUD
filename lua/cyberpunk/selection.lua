CyberPunk = CyberPunk or {}
-- ENUMS всегда не помешает
CP_MOVE_UP = true
CP_MOVE_DOWN = false
hook.Add("CreateMove", "CyberPunkMove", function(cmd)
	if ( cmd:GetMouseWheel() != 0 ) and !cmd:KeyDown(IN_WEAPON1) and !cmd:KeyDown(IN_WEAPON2) then
		cmd:SelectWeapon(CyberPunk.WeaponsMove(cmd:GetMouseWheel() > 0))
	end
end)
function CyberPunk.TranslateWeapons()
	local table1 = LocalPlayer():GetWeapons()
	table.sort( table1, function(a, b) return a:GetSlotPos() * a:GetSlot() < b:GetSlotPos() * b:GetSlot() end )
	table.sort( table1, function(a, b) return a:GetSlot() < b:GetSlot() end )
	return table1
end 
function CyberPunk.WeaponsMove(bool, curpos, curpos1) -- ENUM'ки используем
	local table1 = CyberPunk.TranslateWeapons()
	local pos1 = curpos1 or table.KeyFromValue(table1, LocalPlayer():GetActiveWeapon()) or 1
	if bool then
		return table1[pos1+1] or table1[1]
	else
		local len = #table1
		return table1[pos1-1] or table1[len]
	end
end