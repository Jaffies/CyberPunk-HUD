CyberPunk = CyberPunk or {}
CYBERPUNK_LASTDMG = {shoot = 0, time = 0}
CYBERPUNKHEALTH = 100
CYBERPUNKHEALBARHEALTH = nil
CYBERPUNKHEALBARHEALTHOLD = nil
CYBERPUNK_SUITPOWER = 0
CYBERPUNK_OPENED = false
local disable = {
    ['CHudHealth'] =true,
    ['CHudBattery'] =true,
    ['CHudSuitPower'] =true,
    ['CHudAmmo'] =true,
    ['CHudChat'] =true,
    ['CHudSecondaryAmmo'] =true,
    ['DarkRP_LocalPlayerHUD'] =true,
    ['DarkRP_Hungermod'] =true,
    ['DarkRP_LockdownHUD'] =true,
    ['CHudVoiceSelfStatus'] =true,
    ['CHudVoiceStatus'] =true,
    ['CHudWeaponSelection'] =true,
    ['DarkRP_Agenda'] = true,
    ['TTTInfoPanel'] = true,
    ['TTTVoice'] = true,
}
hook.Add("HUDShouldDraw", "CyberPunkShould", function(hud)
	if !GetConVar("cb_enable"):GetBool() then return end
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
local plymeta = FindMetaTable("Player")
function plymeta:drawPlayerInfo()
	local ply = self
	local pos = ply:GetPos() + Vector(0, 0, 80)
	cam.Start3D2D( pos, Angle( 0, EyeAngles().y - 90, 94), 0.25 )
		draw.SimpleTextOutlined(ply:GetName(), "Robotron32", 2, 2, team.GetColor(ply:Team()), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0))
	cam.End3D2D()
end
function CyberPunk.GetColor(int)
	if engine.ActiveGamemode() == "darkrpbase" or engine.ActiveGamemode() == "darkrp" then
		local ply = FindMetaTable("Player")
		local wanted = isfunction(ply.GetWanted) and LocalPlayer():GetWanted() or isfunction(ply.GetDarkRPVar) and LocalPlayer():GetDarkRPVar "wanted" or LocalPlayer():getDarkRPVar "wanted"
		local sin = wanted and math.sin(CurTime()*2) * 100 or 0
		if GetConVar("cb_jobcolor"):GetBool() then
			local col = team.GetColor(LocalPlayer():Team())
			local col1 = Color(col.r+sin, col.g+sin, col.b+sin)
			local col2 = Color(255-col.r+sin, 255-col.g+sin, 255-col.b+sin)
			local col3 = Color(col.g+sin, col.b+sin, col.r+sin)
			if int == 1 then return col1 end
			if int == 2 then return col2 end
			if int == 3 then return col3 end
		end
		if int == 1 then -- RED
			return GetConVar("cb_johnny"):GetBool() and Color(234+sin, 242+sin, 114+sin) or Color(237+sin, 119+sin, 90+sin)
		elseif int == 2 then -- BLUE
			return GetConVar("cb_johnny"):GetBool() and Color(35+sin, 87+sin, 183+sin) or Color(108+sin, 232+sin, 242+sin)
		elseif int == 3 then
			return GetConVar("cb_johnny"):GetBool() and Color(146+sin, 227+sin, 213+sin) or Color(235+sin, 196+sin, 61+sin)
		end
	else
		if int == 1 then -- RED
			return GetConVar("cb_johnny"):GetBool() and Color(234, 242, 114) or Color(237, 119, 90)
		elseif int == 2 then -- BLUE
			return GetConVar("cb_johnny"):GetBool() and Color(35, 87, 183) or Color(108, 232, 242)
		elseif int == 3 then
			return GetConVar("cb_johnny"):GetBool() and Color(146, 227, 213) or Color(235, 196, 61)
		end
	end
end
function height(y)
	return ScrH() * y
end
function width(x)
	return ScrW() * x --3
end
function ents.FindNpcs()
	local tab = {}
	local EyePos = function() return LocalPlayer():EyePos() end
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
local sound = surface.PlaySound
function surface.PlaySound(snd) -- Made for detecting venty's cyberhacks menu open
	if snd == "venty/cyberact.mp3" then CYBERPUNK_OPENED = !CYBERPUNK_OPENED end
	sound(snd)
end
local bg_colors = { -- TTT support
   noround = Color(100,100,100,200),
   traitor = Color(200, 25, 25, 200),
   innocent = Color(25, 200, 25, 200),
   detective = Color(25, 25, 200, 200)
};
RunConsoleCommand("ttt_weaponswitcher_fast", 1)
hook.Add("HUDPaint", "CyberPunkPaint", function()
	local ply = FindMetaTable("Player")
	if !GetConVar("cb_enable"):GetBool() or CYBERPUNK_OPENED then return end
	if engine.ActiveGamemode() == "terrortown" then
		local color = GAMEMODE.round_state != ROUND_ACTIVE and Color(100,100,100) or LocalPlayer():GetTraitor() and Color(200, 25, 25) or LocalPlayer():GetDetective() and Color(25, 25, 200) or Color(25, 200, 25)
		local name = GAMEMODE.round_state != ROUND_ACTIVE and "No round" or LocalPlayer():GetTraitor() and "Traitor" or LocalPlayer():GetDetective() and "Detective" or "Innocent"
		CyberPunk.SetRadarState(name, color, Color(0, 0, 0), math.floor((12 / 768) * ScrH()), -2)
	elseif engine.ActiveGamemode() == "darkrpbase" or engine.ActiveGamemode() == "darkrp" then
		local job = isfunction(ply.GetJobName) and LocalPlayer():GetJobName() or isfunction(ply.GetJob) and LocalPlayer():GetJob() or isfunction(ply.GetDarkRPVar) and LocalPlayer():GetDarkRPVar("job") or LocalPlayer():getDarkRPVar("job")
		local wanted = isfunction(ply.GetWanted) and LocalPlayer():GetWanted() or isfunction(ply.GetDarkRPVar) and LocalPlayer():GetDarkRPVar "wanted" or isfunction(ply.getDarkRPVar) and LocalPlayer():getDarkRPVar "wanted" or false
		local sin = wanted and math.sin(CurTime()*2) * 100 or 0
		local color = team.GetColor(LocalPlayer():Team())
		CyberPunk.SetRadarState(job, Color(color.r+sin, color.g+sin, color.b+sin), Color(0, 0, 0), math.floor((12 / 768) * ScrH()), -2)
	else
		if GetConVar("cb_radartext"):GetString() == "" and CYBERPUNK_LASTDMG.time - CurTime() > 0 and CYBERPUNK_LASTDMG.shoot - CurTime() > 0 then
			CyberPunk.SetRadarState("COMBAT", CyberPunk.GetColor(1), Color(0, 0, 0), math.floor((12 / 768) * ScrH()), -2)
		elseif GetConVar("cb_radartext"):GetString() != "" then
			CyberPunk.SetRadarState(GetConVar("cb_radartext"):GetString(), Color(GetConVar("cb_radarcolorr"):GetInt(), GetConVar("cb_radarcolorg"):GetInt(), GetConVar("cb_radarcolorb"):GetInt()), Color(GetConVar("cb_radarcolor1r"):GetInt(), GetConVar("cb_radarcolor1g"):GetInt(), GetConVar("cb_radarcolor1b"):GetInt()), GetConVar("cb_radartextsize"):GetInt(), -2)
		end
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
		if engine.ActiveGamemode() == "darkrpbase" or engine.ActiveGamemode() == "darkrp" then
			local ply = FindMetaTable("Player")
			local ply1 = LocalPlayer()
			local hunger = isfunction(ply.GetHunger) and ply1:GetHunger() or isfunction(ply.GetEnergy) and ply1:GetEnergy() or isfunction(ply.GetDarkRPVar) and ply1:GetDarkRPVar "Energy" or ply1:getDarkRPVar "Energy"
			if hunger then
				CyberPunk.DrawAdditionalBar(10, hunger )
			end
		end
		if LocalPlayer():GetActiveWeapon() != NULL then
			CyberPunk.DrawWeaponBar(LocalPlayer():GetActiveWeapon())
			CyberPunk.DrawHealthBarPanel( LocalPlayer():GetAmmoCount( LocalPlayer():GetActiveWeapon():GetSecondaryAmmoType()) )
			if LocalPlayer():GetActiveWeapon():GetMaxClip2() > 0 then
				if engine.ActiveGamemode() != "darkrpbase" or engine.ActiveGamemode() == "darkrp" then
					CyberPunk.DrawAdditionalBar(LocalPlayer():GetActiveWeapon():GetMaxClip2(), LocalPlayer():GetActiveWeapon():Clip2() / LocalPlayer():GetActiveWeapon():GetMaxClip2() )
				end
			end
			if GetConVar("cb_icon"):GetBool() then
				CyberPunk.DrawIcon(LocalPlayer():GetActiveWeapon())
			end
		else
			CyberPunk.DrawHealthBarPanel(0 )
		end
	end
end)