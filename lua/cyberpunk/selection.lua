CyberPunk = CyberPunk or {}
-- ENUMS всегда не помешает
CP_MOVE_UP = true
CP_MOVE_DOWN = false
hook.Add("CreateMove", "CyberPunkMove", function(cmd)
	if ( cmd:GetMouseWheel() != 0 ) and !cmd:KeyDown(IN_WEAPON1) and !cmd:KeyDown(IN_WEAPON2) and !cmd:KeyDown(IN_ATTACK) and !cmd:KeyDown(IN_ATTACK2) and !GetConVar("cb_selection"):GetBool() then
		if IsValid(CyberPunk.WeaponsMove(cmd:GetMouseWheel() > 0)) then
			cmd:SelectWeapon(CyberPunk.WeaponsMove(cmd:GetMouseWheel() > 0))
		end
	end
end)
function CyberPunk.TranslateWeapons()
	local table1 = LocalPlayer():GetWeapons()
	table.sort( table1, function(a, b) return a:GetSlot() * 100000 + a:GetSlotPos() > b:GetSlot() * 100000 + b:GetSlotPos() end )
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
CyberPunk.weaponstab = {}
hook.Add("Think", "CyberPunkWeapons", function()
	local weap = LocalPlayer():GetActiveWeapon()
	if !IsValid(weap) then return end
	if !CyberPunk.weaponstab[weap] and #weap:GetModel() > 0 then
		CyberPunk.weaponstab[weap] = CyberPunk.CreateIcon(weap)
	end
end)
function CyberPunk.CreateIcon(weap)
	local icon = GetRenderTarget(weap:GetClass(), 256, 256, true)
	local weapmodel = weap:GetModel()
	render.PushRenderTarget(icon)
		local model = ClientsideModel(weapmodel) or weap
		local maxs, mins = model:GetModelBounds()
		local max, min =maxs:Length2D(), mins:Length2D()
		if model != weap then model:Remove() end
		local angle = math.abs(maxs[1])+math.abs(mins[1]) > math.abs(maxs[2])+math.abs(mins[2]) and Angle(0,90,0) or Angle(0,9,0)
		render.OverrideAlphaWriteEnable( true, true )
		render.SetWriteDepthToDestAlpha( true )
		render.Clear(0,0,0,0,true,true)
		render.SetStencilWriteMask( 0xFF )
		render.SetStencilTestMask( 0xFF )
		render.SetStencilReferenceValue( 0 )
		render.SetStencilPassOperation( STENCIL_KEEP )
		render.SetStencilFailOperation( STENCIL_KEEP )
		render.SetStencilZFailOperation( STENCIL_KEEP )
		render.ClearStencil()
		render.SetStencilEnable( true )
		render.SetStencilReferenceValue( 1 )
		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilFailOperation( STENCIL_REPLACE )
			cam.Start3D(mins, Angle(0,0,0), min+max, 0, 0, icon:Width(), icon:Height(), 2, 512)
				render.Model({
					model = weapmodel,
					pos = Vector(64,0,0) - Vector((maxs[1]-mins[1]) /2,(maxs[2]-mins[2]) /2,(maxs[3]-mins[3]) /2 ),
					angle = angle,
				})
			cam.End3D()
		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.ClearBuffersObeyStencil(255, 255, 255, 255, false);
		render.SetStencilEnable( false )
		---
		render.SetStencilWriteMask( 0xFF )
		render.SetStencilTestMask( 0xFF )
		render.SetStencilReferenceValue( 0 )
		render.SetStencilPassOperation( STENCIL_KEEP )
		render.SetStencilFailOperation( STENCIL_KEEP )
		render.SetStencilZFailOperation( STENCIL_KEEP )
		render.ClearStencil()
		render.SetStencilEnable( true )
		render.SetStencilReferenceValue( 1 )
		render.SetStencilCompareFunction( STENCIL_KEEP )
		render.SetStencilFailOperation( STENCIL_REPLACE )
			cam.Start3D(mins, Angle(0,0,0), (min+max)*1.03, 0, 0, icon:Width(), icon:Height(), 2, 512)
				render.Model({
					model = weapmodel,
					pos = Vector(64,0,0) - Vector((maxs[1]-mins[1]) /2,(maxs[2]-mins[2]) /2,(maxs[3]-mins[3]) /2 ),
					angle = angle,
				})
		cam.End3D()
		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.ClearBuffersObeyStencil(125, 125, 125, 255, false);
		render.SetStencilEnable( false )
		render.PopRenderTarget()
	return icon
end