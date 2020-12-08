CyberPunk = CyberPunk or {}
CYBERPUNK_LASTDMG = {shoot = 0, time = 0}
CYBERPUNKHEALTH = 100
CYBERPUNKHEALBARHEALTH = nil
CYBERPUNKHEALBARHEALTHOLD = nil
CYBERPUNK_SUITPOWER = 0
local disable = {
	CHudAmmo = true,
	CHudBattery = true,
	CHudDamageIndicator = true,
	CHudHealth = true,
	CHudPoisonDamageIndicator = true,
	CHudSecondaryAmmo = true,
	CHudSquadStatus = true,
	CHudZoom = true,
	CHudWeaponSelection = true,
	CHudSuitPower = true
}
hook.Add("HUDShouldDraw", "CyberPunkShould", function(hud)
	return hud == "CHudWeaponSelection" and GetConVar("cb_selection"):GetBool() or not disable[hud]
end)
hook.Add("DoAnimationEvent", "CyberPunkFire", function(ply, pos, ang, event, name)
	if pos == 0 and ply == LocalPlayer() then
		CYBERPUNK_LASTDMG.shoot = math.max(CYBERPUNK_LASTDMG.shoot, CurTime() + 8)
	end
end)
hook.Add("DrawDeathNotice", "CyberPunkNotice", function()
	return false
end)
function height(y)
	return ScrH() * y
end
function width(x)
	return ScrW() * x --3
end
function ents.FindNpcs()
	local tab = {}
	for k, v in pairs(ents.GetAll()) do
		if math.Dist(v:GetPos().x, v:GetPos().y, EyePos().x, EyePos().y) <= 1024 and v:IsNPC() or v:GetPos():DistToSqr(EyePos()) <= 1048576 and v:IsPlayer() and v != LocalPlayer() and v:Alive() or v:GetPos():DistToSqr(EyePos()) <= 1048576 and v:IsNextBot()  then
			table.insert(tab, v)
		end
	end
	return tab
end
hook.Add("Think", "CyberPunkThink", function()
	if CYBERPUNKHEALBARHEALTH == nil then CYBERPUNKHEALBARHEALTH = LocalPlayer():GetMaxHealth() end
	if CYBERPUNKHEALBARHEALTH != LocalPlayer():Health() and CYBERPUNKHEALBARHEALTHOLD == nil then
		CYBERPUNKHEALBARHEALTHOLD = {hp = CYBERPUNKHEALBARHEALTH, time = CurTime() + 0.8}
		CYBERPUNKHEALBARHEALTH = Lerp( math.Clamp((CYBERPUNKHEALBARHEALTHOLD.time - CurTime()) * 1.25, 0, 1 ), LocalPlayer():Health(), CYBERPUNKHEALBARHEALTHOLD.hp)
	elseif CYBERPUNKHEALBARHEALTH == LocalPlayer():Health() then
		CYBERPUNKHEALBARHEALTHOLD = nil
	else
		CYBERPUNKHEALBARHEALTH = Lerp( math.Clamp( (CYBERPUNKHEALBARHEALTHOLD.time - CurTime() ) * 1.25, 0, 1 ) , LocalPlayer():Health(), CYBERPUNKHEALBARHEALTHOLD.hp)
	end
	if LocalPlayer():Health() < CYBERPUNKHEALTH then
		CYBERPUNKHEALTH = LocalPlayer():Health()
		CYBERPUNK_LASTDMG.time = CurTime() + 8
	else 
		CYBERPUNKHEALTH = LocalPlayer():Health()
	end
	if IsValid(LocalPlayer():GetActiveWeapon()) then
		local shoottime = LocalPlayer():GetActiveWeapon():LastShootTime()
		CYBERPUNK_LASTDMG.shoot = math.max( CYBERPUNK_LASTDMG.shoot, shoottime + 8 )
	else
		CYBERPUNK_LASTDMG.shoot = math.max(CYBERPUNK_LASTDMG.shoot, 0)
	end
end)
hook.Add("HUDPaint", "CyberPunkPaint", function()
	if #GetConVar("cb_radartext"):GetString() == 0 and CYBERPUNK_LASTDMG.time - CurTime() > 0 and CYBERPUNK_LASTDMG.shoot - CurTime() > 0 then
		CyberPunk.SetRadarState("COMBAT", Color(245, 86, 83), Color(0, 0, 0), 11, -2)
	elseif #GetConVar("cb_radartext"):GetString() > 0 then
		CyberPunk.SetRadarState(GetConVar("cb_radartext"):GetString(), Color(GetConVar("cb_radarcolorr"):GetInt(), GetConVar("cb_radarcolorg"):GetInt(), GetConVar("cb_radarcolorb"):GetInt()), Color(GetConVar("cb_radarcolor1r"):GetInt(), GetConVar("cb_radarcolor1g"):GetInt(), GetConVar("cb_radarcolor1b"):GetInt()), GetConVar("cb_radartextsize"):GetInt(), -2)
	end
	if !GetConVar("cb_drawdead"):GetBool() and LocalPlayer():Alive() or GetConVar("cb_drawdead"):GetBool() then
		local CYBERPUNKHEALBARHEALTH = CYBERPUNKHEALBARHEALTH or LocalPlayer():Health()
		if GetConVar("cb_radar"):GetBool() then
			CyberPunk.DrawRadar(CyberPunk.LandMarkConvert(ents.FindNpcs()))
		else
			CyberPunk.DrawOldRadar(CyberPunk.LandMarkConvert(ents.FindNpcs()))
		end
		CyberPunk.DrawHealthBar( math.Clamp( CYBERPUNKHEALBARHEALTH / LocalPlayer():GetMaxHealth(), 0, 1), LocalPlayer():Health() / LocalPlayer():GetMaxHealth() )
		if LocalPlayer():GetSuitPower() != 100 then
			CYBERPUNK_SUITPOWER = math.Clamp( CYBERPUNK_SUITPOWER + 25, 0, 255)
		else
			CYBERPUNK_SUITPOWER = math.Clamp( CYBERPUNK_SUITPOWER - 25, 0, 255)
		end
		CyberPunk.DrawStaminaBar(LocalPlayer():GetSuitPower() / 100, CYBERPUNK_SUITPOWER)
		CyberPunk.DrawEXPBar(LocalPlayer():Armor() / LocalPlayer():GetMaxArmor())
		CyberPunk.DrawStaminaInfo(true, "STAMINA", CYBERPUNK_SUITPOWER)
		if LocalPlayer():GetActiveWeapon() != NULL then
			--if LocalPlayer():GetActiveWeapon().DrawCrosshair then
				-- Рисуем прицел
		--		CyberPunk.DrawCrosshair()
			--end
			CyberPunk.DrawWeaponBar(LocalPlayer():GetActiveWeapon())
			CyberPunk.DrawHealthBarPanel( LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType()) )
			if LocalPlayer():GetActiveWeapon():GetMaxClip2() > 0 then
				CyberPunk.DrawAdditionalBar(LocalPlayer():GetActiveWeapon():GetMaxClip2(), LocalPlayer():GetActiveWeapon():Clip2() / LocalPlayer():GetActiveWeapon():GetMaxClip2() )
			end
			if GetConVar("cb_icon"):GetBool() then
				CyberPunk.DrawIcon(LocalPlayer():GetActiveWeapon())
			end
		else
			CyberPunk.DrawHealthBarPanel(0 )
		end
	end
end)