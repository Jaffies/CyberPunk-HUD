CyberPunk = CyberPunk or {}
CYBERPUNK_RADAR_STATE_PUBLIC = { state = "Public", color = Color(108, 232, 242), color1 = Color(0, 0, 0), size = 10, time = -1}
CYBERPUNK_RADAR_STATE = {}
function CyberPunk.SetRadarState(name, color, color1, size,  time)
	if time == -1 then
		CYBERPUNK_RADAR_STATE = { state = name, color = color, color1 = color1, size = size, time = -1}
	elseif time == -2 then
		CYBERPUNK_RADAR_STATE = { state = name, color = color, color1 = color1, size = size, time = -2}
	else
		CYBERPUNK_RADAR_STATE = { state = name, color = color, color1 = color1, size = size, time = CurTime() + time}
	end
end
function CyberPunk.ResetRadarState()
	CYBERPUNK_RADAR_STATE = {time = 0}
end
function CyberPunk.DrawOldRadar(table1)
	local tab = table1 or {}
	local toptab = {
		{ x = width(0.948), y = height(0.005) },
		{ x = width(0.947), y = height(0.0078125) },
		{ x = width(0.8286), y = height(0.02083)},
		{ x = width(0.826), y = height(0.005) }
	}
	local lefttab = {
		{x = width(0.8286), y = height(0.02083)},
		{x = width(0.8286), y = height(0.058593)},
		{x = width(0.826), y = height(0.058593)},
		{x = width(0.826), y = height(0.005)},
	
	}
	local lefttab1 = {
		{x = width(0.8286), y = height(0.058593)}, -- Левый верхний угол
		{x = width(0.83089), y = height(0.0625)},
		{x = width(0.83089), y = height(0.1848958)},
		{x = width(0.826), y = height(0.18880208)},
		{x = width(0.826), y = height(0.058593)} -- Правый верхний угол
	}
	local lefttab3 = {
		{x = width(0.826), y = height(0.18880208)}, -- Левый верхний угол
		{x = width(0.827), y = height(0.18)},
		{x = width(0.826), y = height(0.23958)}
	}
	local downtab = {
		{x = width(0.826), y = height(0.23177)}, -- Правый верхний
		{x = width(0.8286), y = height(0.238)},
	--	{x = width(0.945095168), y = height(0.233072916)},
	--	{x = width(0.948), y = height(0.23958)},
		{x = width(0.826), y = height(0.23958)}
	}
	local downtab1 = {
		{x = width(0.8286), y = height(0.238)},
		{x = width(0.945095168), y = height(0.233072916)},
		{x = width(0.949), y = height(0.23958)},
		{x = width(0.826), y = height(0.23958)}
	}
	local righttab = {
		{x = width(0.945095168), y = height(0.233072916)},
		{x = width(0.949), y = height(0.005)},
		{x = width(0.949), y = height(0.23958)}
	}
	draw.NoTexture()
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()
	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilCompareFunction( STENCIL_NEVER )
	render.SetStencilFailOperation( STENCIL_REPLACE )
		surface.SetDrawColor(0, 50, 70, 255)
		surface.DrawPoly(toptab)
		surface.DrawPoly(lefttab)
		surface.DrawPoly(lefttab1)
		surface.DrawPoly(lefttab3)
		surface.DrawPoly(downtab)
		surface.DrawPoly(downtab1)
		surface.DrawPoly(righttab)
		surface.DrawRect(width(0.948), height(0.005), width(0.1208), height(0.234375))
		surface.DrawRect(0, 0, width(0.827), ScrH())
		surface.DrawRect(width(0.827), 0, width(0.5), height(0.01))
		surface.DrawRect(width(0.827), height(0.23958), width(0.5), height(0.8))
	render.SetStencilCompareFunction( STENCIL_NOTEQUAL )
	render.SetStencilFailOperation( STENCIL_KEEP )
		surface.SetDrawColor(0, 25, 50, 210)
		surface.DrawRect(width(0.827), height(0.00651), width(0.12), height(0.234375))
		for k, v in pairs(tab) do
			if v.type == "Landmark" then
				CyberPunk.DrawLandMark(width(0.8874), height(0.1236975), v.angle, ( ScrH() / 768 ) * 6, v.dist / 8.5, v.color)
			elseif v.type == "Cursor" then
				CyberPunk.DrawCursor(width(0.8874) - math.sin(math.rad(v.angle)) * v.dist / 8.5, height(0.1236975) - math.cos(math.rad(v.angle)) * v.dist / 8.5, v.selfangle, ( ScrH() / 768 ) * 6, v.color)
			end
		end
--		surface.SetDrawColor(50, 50, 255, 255)
		if CYBERPUNK_RADAR_STATE.time == nil or CYBERPUNK_RADAR_STATE.time < CurTime() and CYBERPUNK_RADAR_STATE.time != -1 and CYBERPUNK_RADAR_STATE.time != -2 then
			local size1 = ( #CYBERPUNK_RADAR_STATE_PUBLIC.state * (CYBERPUNK_RADAR_STATE_PUBLIC.size * 0.62) ) / ScrW()
			local size2 =  CYBERPUNK_RADAR_STATE_PUBLIC.size / ScrH()
			draw.RoundedBoxEx(math.max( size2 * ScrW(), size1 * ScrH() ), width(0.93 - size1), height(0.225 - size2), width(0.018604319 + size1), height(0.0200416 + size2), CYBERPUNK_RADAR_STATE_PUBLIC.color, true)
			draw.SimpleText(CYBERPUNK_RADAR_STATE_PUBLIC.state, "RobotronBlury" .. tostring(CYBERPUNK_RADAR_STATE_PUBLIC.size), width(0.935 - size1), height(0.22884375 - size2), CYBERPUNK_RADAR_STATE_PUBLIC.color1)
			draw.SimpleText(CYBERPUNK_RADAR_STATE_PUBLIC.state, "Robotron" .. tostring(CYBERPUNK_RADAR_STATE_PUBLIC.size), width(0.935 - size1), height(0.22884375 - size2), Color(CYBERPUNK_RADAR_STATE_PUBLIC.color1.r - 40, CYBERPUNK_RADAR_STATE_PUBLIC.color1.g - 40, CYBERPUNK_RADAR_STATE_PUBLIC.color1.b - 40, CYBERPUNK_RADAR_STATE_PUBLIC.color1.a))
		else
			local size1 = ( #CYBERPUNK_RADAR_STATE.state * (CYBERPUNK_RADAR_STATE.size * 0.62) ) / ScrW()
			local size2 =  CYBERPUNK_RADAR_STATE.size / ScrH()
			draw.RoundedBoxEx(math.max( size2 * ScrW(), size1 * ScrH() ), width(0.93 - size1), height(0.225 - size2), width(0.018604319 + size1), height(0.0200416 + size2), CYBERPUNK_RADAR_STATE.color, true)
			draw.SimpleText(CYBERPUNK_RADAR_STATE.state, "RobotronBlury" .. tostring(CYBERPUNK_RADAR_STATE.size), width(0.935 - size1), height(0.22884375 - size2), Color(CYBERPUNK_RADAR_STATE.color1.r - 40, CYBERPUNK_RADAR_STATE.color1.g - 40, CYBERPUNK_RADAR_STATE.color1.b - 40, CYBERPUNK_RADAR_STATE.color1.a))
			draw.SimpleText(CYBERPUNK_RADAR_STATE.state, "Robotron" .. tostring(CYBERPUNK_RADAR_STATE.size), width(0.935 - size1), height(0.22884375 - size2), CYBERPUNK_RADAR_STATE.color1)
			if CYBERPUNK_RADAR_STATE.time == -2 then CYBERPUNK_RADAR_STATE = {} end
		end
		local booln = LocalPlayer():EyePos() == EyePos()
		local plyangle = booln and 0 or ( LocalPlayer():EyePos() - EyePos() ):Angle().y - EyeAngles().y
		local plyselfangle = booln and 0 or LocalPlayer():GetAngles().y - EyeAngles().y
		local plydist = math.Distance(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, EyePos().x, EyePos().y) / 8.5
		CyberPunk.DrawCursor(width(0.8874) - math.sin(math.rad(plyangle)) * plydist, height(0.1236975) - math.cos(math.rad(plyangle)) * plydist , plyselfangle, ( ScrH() / 768 ) * 7, CYBERPUNK_RADAR_STATE_PUBLIC.color)
		surface.DrawCircle(width(0.932), height(0.038), width(0.013), 177, 106, 115, 200)
		draw.RoundedBox(50, width(0.932) - width(0.004) /2 , height(0.038) - height(0.007) / 2, width(0.004), height(0.007), Color(177, 106, 115, 200))
		CyberPunk.DrawCursor(width(0.932) - math.sin(math.rad( EyeAngles().y) ) * ( ( ScrW() / 1366 ) * 8 ), height(0.038) - math.cos(math.rad( EyeAngles().y) ) * ( ( ScrH() / 768 ) * 8 ), EyeAngles().y, ( ScrH() / 768 ) * 5,  Color(177, 106, 115, 200))
		render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilEnable( false )
	draw.SimpleText(os.date("%I:%M %p", os.time()), "RobotronBlury" .. tostring(math.Round( height(0.0130208) )), width(0.8352855), height(0.24088541), Color(68, 92, 202))
		draw.SimpleText(os.date("%I:%M %p", os.time()), "Robotron" .. tostring(math.Round( height(0.0130208) )), width(0.8352855), height(0.24088541), Color(108, 232, 242))
end
function CyberPunk.DrawRadar(table1)
	local tab = table1 or {}
	local toptab = {
		{ x = width(0.948), y = height(0.005 + 0.0325)},
		{ x = width(0.947), y = height(0.0078125 + 0.0325)},
		{ x = width(0.8286), y = height(0.02083 + 0.0325)},
		{ x = width(0.826), y = height(0.005 + 0.0325)}
	}
	local lefttab = {
		{x = width(0.8286), y = height(0.02083 + 0.0325)},
		{x = width(0.8286), y = height(0.058593 + 0.0325)},
		{x = width(0.826), y = height(0.058593 + 0.0325)},
		{x = width(0.826), y = height(0.005 + 0.0325)},
	
	}
	local lefttab1 = {
		{x = width(0.8286), y = height(0.058593 + 0.0325)}, -- Левый верхний угол
		{x = width(0.83089), y = height(0.0625 + 0.0325)},
		{x = width(0.83089), y = height(0.1848958 + 0.0325)},
		{x = width(0.826), y = height(0.18880208 + 0.0325)},
		{x = width(0.826), y = height(0.058593 + 0.0325)} -- Правый верхний угол
	}
	local lefttab3 = {
		{x = width(0.826), y = height(0.18880208 + 0.0325)}, -- Левый верхний угол
		{x = width(0.827), y = height(0.18 + 0.0325)},
		{x = width(0.826), y = height(0.23958 + 0.0325)}
	}
	local downtab = {
		{x = width(0.826), y = height(0.23177 + 0.0325)}, -- Правый верхний
		{x = width(0.8286), y = height(0.238 + 0.0325)},
	--	{x = width(0.945095168), y = height(0.233072916 + 0.0325)},
	--	{x = width(0.948), y = height(0.23958 + 0.0325)},
		{x = width(0.826), y = height(0.23958 + 0.0325)}
	}
	local downtab1 = {
		{x = width(0.8286), y = height(0.238 + 0.0325)},
		{x = width(0.945095168), y = height(0.233072916 + 0.0325)},
		{x = width(0.948), y = height(0.23958 + 0.0325)},
		{x = width(0.826), y = height(0.23958 + 0.0325)}
	}
	local righttab = {
		{x = width(0.945095168), y = height(0.233072916 + 0.0325)},
		{x = width(0.948), y = height(0.005 + 0.0325)},
		{x = width(0.948), y = height(0.23958 + 0.0325)}
	}
	draw.NoTexture()
	render.SetStencilWriteMask( 0xFF )
	render.SetStencilTestMask( 0xFF )
	render.SetStencilReferenceValue( 0 )
	render.SetStencilPassOperation( STENCIL_KEEP )
	render.SetStencilZFailOperation( STENCIL_KEEP )
	render.ClearStencil()
	render.SetStencilEnable( true )
	render.SetStencilReferenceValue( 1 )
	render.SetStencilCompareFunction( STENCIL_NEVER )
	render.SetStencilFailOperation( STENCIL_REPLACE )
		surface.SetDrawColor(0, 50, 70, 255)
		surface.DrawPoly(toptab)
		surface.DrawPoly(lefttab)
		surface.DrawPoly(lefttab1)
		surface.DrawPoly(lefttab3)
		surface.DrawPoly(downtab)
		surface.DrawPoly(downtab1)
		surface.DrawPoly(righttab)
		surface.DrawRect(width(0.948), height(0.005 + 0.0325), width(0.1208), height(0.234375 + 0.0325))
		surface.DrawRect(0, 0, width(0.827), ScrH())
		surface.DrawRect(width(0.827), 0, width(0.5), height(0.01 + 0.0325))
		surface.DrawRect(width(0.827), height(0.23958 + 0.0325), width(0.5), height(0.8 + 0.0325))
	render.SetStencilCompareFunction( STENCIL_NOTEQUAL )
	render.SetStencilFailOperation( STENCIL_KEEP )
		surface.SetDrawColor(0, 25, 50, 210)
		surface.DrawRect(width(0.827), height(0.00651 + 0.0325), width(0.12), height(0.234375 + 0.0325))
		for k, v in pairs(tab) do
			if v.type == "Landmark" then
				CyberPunk.DrawLandMark(width(0.8874), height(0.1236975 + 0.0325), v.angle, ( ScrH() / 768 ) * 6, v.dist / 8.5, v.color)
			elseif v.type == "Cursor" then
				CyberPunk.DrawCursor(width(0.8874) - math.sin(math.rad(v.angle)) * v.dist / 8.5, height(0.1236975 + 0.0325) - math.cos(math.rad(v.angle)) * v.dist / 8.5, v.selfangle, ( ScrH() / 768 ) * 6, v.color)
			end
		end
--		surface.SetDrawColor(50, 50, 255, 255)
		if CYBERPUNK_RADAR_STATE.time != nil and CYBERPUNK_RADAR_STATE.time > CurTime() or CYBERPUNK_RADAR_STATE.time != nil and CYBERPUNK_RADAR_STATE.time == -1 or CYBERPUNK_RADAR_STATE.time != nil and CYBERPUNK_RADAR_STATE.time == -2 then
			local size1 = ( #CYBERPUNK_RADAR_STATE.state * (CYBERPUNK_RADAR_STATE.size * 0.62) ) / ScrW()
			local size2 =  CYBERPUNK_RADAR_STATE.size / ScrH()
			local plazhkatab = {
				{x = width(0.964128), y = height(0.255 - size2)},
				{x = width(0.964128), y = height(0.272135)},
				{x = width(0.826), y = height(0.271)},
				{x = width(0.826), y = height(0.265 - size2)},
			}
			surface.SetDrawColor(CYBERPUNK_RADAR_STATE.color.r, CYBERPUNK_RADAR_STATE.color.g, CYBERPUNK_RADAR_STATE.color.b)
			draw.NoTexture()
			surface.DrawPoly(plazhkatab)
			draw.SimpleText(CYBERPUNK_RADAR_STATE.state, "RobotronBlury" .. tostring(CYBERPUNK_RADAR_STATE.size), width(0.8874), height(0.23 + 0.0325), Color(CYBERPUNK_RADAR_STATE.color1.r - 40, CYBERPUNK_RADAR_STATE.color1.g - 40, CYBERPUNK_RADAR_STATE.color1.b - 40, CYBERPUNK_RADAR_STATE.color1.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			draw.SimpleText(CYBERPUNK_RADAR_STATE.state, "Robotron" .. tostring(CYBERPUNK_RADAR_STATE.size), width(0.8874), height(0.23 + 0.0325), CYBERPUNK_RADAR_STATE.color1, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			if CYBERPUNK_RADAR_STATE.time == -2 then CYBERPUNK_RADAR_STATE = {} end
		end
		local booln = LocalPlayer():EyePos() == EyePos()
		local plyangle = booln and 0 or ( LocalPlayer():EyePos() - EyePos() ):Angle().y - EyeAngles().y
		local plyselfangle = booln and 0 or LocalPlayer():GetAngles().y - EyeAngles().y
		local plydist = math.Distance(LocalPlayer():GetPos().x, LocalPlayer():GetPos().y, EyePos().x, EyePos().y) / 8.5
		CyberPunk.DrawCursor(width(0.8874) - math.sin(math.rad(plyangle)) * plydist, height(0.1236975 + 0.0325) - math.cos(math.rad(plyangle)) * plydist , plyselfangle, ( ScrH() / 768 ) * 7, CYBERPUNK_RADAR_STATE_PUBLIC.color)
		-- Кружочек с говном, ставим на другое место.
		render.SetStencilCompareFunction( STENCIL_ALWAYS )
	render.SetStencilEnable( false )
	draw.SimpleText(os.date("%I:%M %p", os.time()), "RobotronBlury" .. tostring(math.Round( height(0.0130208) )), width(0.8352855), height(0.24088541 + 0.0325), Color(68, 92, 202))
		draw.SimpleText(os.date("%I:%M %p", os.time()), "Robotron" .. tostring(math.Round( height(0.0130208) )), width(0.8352855), height(0.24088541 + 0.0325), Color(108, 232, 242))
		surface.DrawCircle(width(0.96), height(0.004 + 0.0325), width(0.01), 177, 106, 115, 200)
		surface.DrawCircle(width(0.96), height(0.004 + 0.0325), width(0.009), 177, 106, 115, 200)
		surface.DrawCircle(width(0.96), height(0.004 + 0.0325), width(0.0095), 177, 106, 115, 200)
		draw.RoundedBox(50, width(.96) - width(0.003) /2 , height(0.004 + 0.0325) - height(0.006) / 2, width(0.003), height(0.006), Color(177, 106, 115, 200))
		CyberPunk.DrawCursor(width(0.96) - math.sin(math.rad( EyeAngles().y) ) * ( ( ScrW() / 1366 ) * 6 ), height(0.004 + 0.0325) - math.cos(math.rad( EyeAngles().y) ) * ( ( ScrH() / 768 ) * 6 ), EyeAngles().y, ( ScrH() / 768 ) * 4,  Color(177, 106, 115, 200))
end
function CyberPunk.LandMarkConvert(tab1)
	local tab = {}
	for k, v in pairs(tab1) do
		if k > 32 then break end
		if v:GetClass() == "npc_turret_floor" and v:GetAngles()[3] > 60 then continue end
		table.insert(tab, {
			color = CyberPunk.RadarEntColor(v),
			angle = ( v:GetPos() - EyePos() ):Angle().y - EyeAngles().y,
			dist = height( math.Distance(EyePos().x, EyePos().y, v:GetPos().x, v:GetPos().y) / 768),
			selfangle = v:EyeAngles().y - EyeAngles().y,
			type = v:IsPlayer() and "Cursor" or "Landmark"
		})
	end
	return tab
end
function CyberPunk.RadarEntColor(ent)
	if ent:IsNextBot() then
		return ent:GetColor() or Color(255, 255, 255)
	end
	if ent:IsPlayer() then
		return team.GetColor( ent:Team() )
	end
	if !radarcolours[ent:GetClass()] then return ent:GetActiveWeapon() == NULL and Color(150, 150, 150) or Color(255, 255, 255) end
	if ent:GetActiveWeapon() == NULL or nil then return Color(175 * radarcolours[ent:GetClass()].r / 255, 175 * radarcolours[ent:GetClass()].g / 255, 175 * radarcolours[ent:GetClass()].b / 255) end
	return radarcolours[ent:GetClass()]
end
radarcolours = {
	npc_combine_s = Color(255, 0, 0),
	npc_metropolice = Color(200, 25, 25),
	npc_manhack = Color(200, 55, 0),
	npc_stalker = Color(255, 0, 0),
	npc_breen = Color(205, 100, 100),
	npc_rollermine = Color(150, 5, 0),
	npc_turret_floor = Color(150, 70, 0),
	npc_turret_ceiling = Color(150, 70, 0),
	npc_combine_camera = Color(100, 100, 0),
	npc_crow = Color(50, 50, 105),
	npc_pigeon = Color(50, 50, 105),
	npc_seagull = Color(50, 50, 105),
	npc_crow = Color(50, 50, 105),
	npc_cscanner = Color(10, 100, 25),
	npc_citizen = Color(100, 255, 0),
	npc_vortigaunt = Color(0, 205, 0),
	npc_gman = Color(0, 0, 0),
	npc_alyx = Color(255, 255, 0),
	npc_dog = Color(255, 255, 70),
	npc_monk = Color(0, 0, 255),
	npc_barney = Color(0, 255, 255),
	npc_kleiner = Color(10, 175, 10),
	npc_zombie = Color(10, 175, 255),
	npc_headcrab = Color(0, 75, 255),
	npc_fast_zombie = Color(50, 175, 200),
	npc_poison_zombie = Color(8, 5, 180),
	npc_eli = Color(50, 150, 50)
}