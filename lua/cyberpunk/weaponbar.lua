CyberPunk = CyberPunk or {}
function CyberPunk.DrawWeaponBar(weapon)
	if !IsValid(weapon) then return end
	local ammo = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType())
	local red = CyberPunk.GetColor(1)
	local blue = CyberPunk.GetColor(2)
	if (weapon:Clip1() == -1 or weapon:Clip1() == 0 )and ammo > 0 then -- Для ракет, гранат и тд
		draw.SimpleText(string.format("%03d", math.min( 999, ammo) ), "Robotron" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895), blue, TEXT_ALIGN_RIGHT)
		draw.SimpleText(string.format("%03d", math.min( 999, ammo) ), "RobotronBlury" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895), blue, TEXT_ALIGN_RIGHT)
	elseif weapon:Clip1() > 0 and weapon:HasAmmo() then -- Для всего другого
		draw.SimpleText(string.format("%03d", math.min( 999, weapon:Clip1()) ), "Robotron" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895),blue, TEXT_ALIGN_RIGHT)
		draw.SimpleText(string.format("%03d", math.min( 999, weapon:Clip1()) ), "RobotronBlury" .. tostring(math.floor(height( 0.02604))), width(0.836749634), height(0.9309895),blue, TEXT_ALIGN_RIGHT)
		draw.SimpleText(string.format("%04d", math.min( 9999, ammo) ), "Robotron" .. tostring(math.floor(height(0.01953125))), width(0.8455344) , height( 0.9309895),red)
		draw.SimpleText(string.format("%04d", math.min( 9999, ammo) ), "RobotronBlury" .. tostring(math.floor(height(0.01953125))), width(0.8455344) , height( 0.9309895),red)
	end
end
function CyberPunk.DrawIcon(weapon) -- Позволяет получить иконку для выбора, или иконку для киллайкона или иконку из спавнменю.
	local weap = LocalPlayer():GetActiveWeapon()
	if CyberPunk.weaponstab[weap] then
		local mat = CreateMaterial( "CyberPunkHUDIcons", "UnLitGeneric", {
		["$basetexture"] = "color/white",
		["$model"] = 1,
		["$translucent"] = 1,
		["$vertexalpha"] = 1,
		["$vertexcolor"] = 1,
		["$additive"] = 1,
		})
		mat:SetTexture("$basetexture", CyberPunk.weaponstab[weap])
		surface.SetMaterial(mat)
		local red = CyberPunk.GetColor(1)
		surface.SetDrawColor(red.r, red.g, red.b, 255)
		surface.DrawTexturedRect(width(0.88360176) , height(0.871875), width(0.0937042459736457), height(0.1666666666666667))
	end
end
