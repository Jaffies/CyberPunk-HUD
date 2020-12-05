CyberPunk = CyberPunk or {}
-- CyberPunk HUD By Jaff, SteamUrl - jaffies
for i = 1, 32 do
	surface.CreateFont("Robotron" .. tostring(i), { -- Меняем Robotron на другой шрифт под названием JLSDAta
		font = "Robotron",
		size = i,
		weight = 600,
	})
	surface.CreateFont("RobotronBlury" .. tostring(i), {
		font = "Robotron",
		size = i,
		weight = 600000,
		blursize = 3,
	})
end
function CyberPunk.DrawCursor(xx, yy, dir, size, col)
	local tr1 = {
		{x = xx - math.sin(math.rad(dir - 125)) * size, y = yy - math.cos(math.rad(dir - 125)) * size},
		{x = xx, y = yy},
		{x = xx - math.sin(math.rad(dir)) * size, y = yy - math.cos(math.rad(dir)) * size}
	}
	local tr2 = {
		{x = xx - math.sin(math.rad(dir)) * size, y = yy - math.cos(math.rad(dir)) * size},
		{x = xx, y = yy},
		{x = xx - math.sin(math.rad(dir + 125)) * size, y = yy - math.cos(math.rad(dir + 125)) * size}
	}
	draw.NoTexture()
	surface.SetDrawColor(col.r, col.g, col.b, col.a)
	surface.DrawPoly(tr1)
	surface.DrawPoly(tr2)
end
function CyberPunk.DrawCrosshair()
	local centerx, centery = ScrW() / 2, ScrH() / 2
	draw.NoTexture()
	surface.SetDrawColor(255, 255, 255)
	surface.DrawLine(centerx - width(0.025), centery, centerx - width(0.002), centery)
	surface.DrawLine(centerx - width(0.025), centery-1, centerx - width(0.002), centery-1)
	surface.DrawLine(centerx + width(0.025), centery, centerx + width(0.002), centery)
	surface.DrawLine(centerx + width(0.05), centery-1, centerx + width(0.025), centery-1)
end
function CyberPunk.DrawLandMark(xx, yy, dir, size, size1, col)
	local xxx = xx - math.sin(math.rad(dir)) * size1
	local yyy = yy - math.cos(math.rad(dir)) * size1
	draw.RoundedBox(size, xxx - size / 2, yyy - size / 2, size, size, col)
end
hook.Add("PostDrawOpaqueRenderables", "CyberPunkNicks", function()
	local trace = LocalPlayer():GetEyeTrace()
	if trace.Hit and IsValid(trace.Entity) and trace.Entity:IsPlayer() then
		local ply = trace.Entity
		local pos = ply:GetPos() + Vector(0, 0, 80)
		cam.Start3D2D( pos, Angle( 0, EyeAngles().y - 90, 90), 0.25 )
			draw.SimpleTextOutlined(ply:GetName(), "Robotron32", 2, 2, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0))
		cam.End3D2D()
	end
end)
hook.Add("HUDDrawTargetID", "CyberPunkDisableNicks", function()
	return false
end)