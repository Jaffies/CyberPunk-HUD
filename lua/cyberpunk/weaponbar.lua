CyberPunk = CyberPunk or {}
function CyberPunk.DrawWeaponBar(weapon, icon)
	local ammo = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType())
	if weapon:GetMaxClip1() > 0 then
		if weapon:Clip1() == -1 then -- Для ракет, гранат и тд
			draw.SimpleText(string.format("%03d", math.min( 999, ammo) ), "Robotron" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895), Color(107,194,197), TEXT_ALIGN_RIGHT)
			draw.SimpleText(string.format("%03d", math.min( 999, ammo) ), "RobotronBlury" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895), Color(107,194,197), TEXT_ALIGN_RIGHT)
		else -- Для всего другого
			draw.SimpleText(string.format("%03d", math.min( 999, weapon:Clip1()) ), "Robotron" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895),Color(107,194,197), TEXT_ALIGN_RIGHT)
			draw.SimpleText(string.format("%03d", math.min( 999, weapon:Clip1()) ), "RobotronBlury" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895),Color(57,134,137), TEXT_ALIGN_RIGHT)
			draw.SimpleText(string.format("%04d", math.min( 9999, ammo) ), "Robotron" .. tostring(math.floor(height(0.01953125))), width(0.8455344) , height( 0.9309895),Color(203,106,93))
			draw.SimpleText(string.format("%04d", math.min( 9999, ammo) ), "RobotronBlury" .. tostring(math.floor(height(0.01953125))), width(0.8455344) , height( 0.9309895),Color(173,76,53))
		end
	end
end
function CyberPunk.DrawIcon(weapon) -- Позволяет получить иконку для выбора, или иконку для киллайкона или иконку из спавнменю.
	draw.NoTexture()
	surface.SetDrawColor(255,255,255)
	if weapon.WepSelectIcon != nil and weapon.WepSelectIcon != surface.GetTextureID( 'weapons/swep' ) then
		surface.SetTexture(weapon.WepSelectIcon)
		surface.DrawTexturedRect(width(0.88360176), height(0.921875), width(0.0592972), height(0.048177))
	elseif killicon.Exists(weapon:GetClass()) then
		killicon.Draw(width(0.915), height(0.921875), weapon:GetClass(), 255)
	elseif !Material("entities/" .. weapon:GetClass() .. ".png"):IsError() then
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(Material("entities/" .. weapon:GetClass() .. ".png"))
		surface.DrawTexturedRect(width(0.88360176) , height(0.921875), width(0.0592972), height(0.048177))
	end
end
