if CLIENT then
	include("cyberpunk/main.lua")
	include("cyberpunk/drawing.lua")
	include("cyberpunk/radar.lua")
	include("cyberpunk/healthbar.lua")
	include("cyberpunk/stamina.lua")
	include("cyberpunk/weaponbar.lua")
	include("cyberpunk/selection.lua")
else
	AddCSLuaFile("cyberpunk/main.lua")
	AddCSLuaFile("cyberpunk/drawing.lua")
	AddCSLuaFile("cyberpunk/radar.lua")
	AddCSLuaFile("cyberpunk/healthbar.lua")
	AddCSLuaFile("cyberpunk/stamina.lua")
	AddCSLuaFile("cyberpunk/weaponbar.lua")
	AddCSLuaFile("cyberpunk/selection.lua")
end
CreateConVar( "cb_selection", 0, FCVAR_ARCHIVE, "Enables default selection menu Default is 0.", 0, 1 )
CreateConVar( "cb_drawdead", 0, FCVAR_ARCHIVE, "Controls drawing hud while you dead. Default is 0.", 0, 1 )
CreateConVar( "cb_radartext", "", FCVAR_ARCHIVE, "Controls drawing radar text. Leave it blank if you want default text")
CreateConVar( "cb_radarcolorr", 0, FCVAR_ARCHIVE, "Controls drawing radar color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radarcolorg", 255, FCVAR_ARCHIVE, "Controls drawing radar color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radarcolorb", 255, FCVAR_ARCHIVE, "Controls drawing radar color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radarcolor1r", 0, FCVAR_ARCHIVE, "Controls drawing radar text color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radarcolor1g", 0, FCVAR_ARCHIVE, "Controls drawing radar text color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radarcolor1b", 0, FCVAR_ARCHIVE, "Controls drawing radar color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_radartextsize", 12, FCVAR_ARCHIVE, "Controls drawing radar color. Doen't work if cb_radartext is balnk", 0, 255)
CreateConVar( "cb_icon", 0, FCVAR_ARCHIVE, "Controls weapon's icon drawing. Default is 0.", 0, 1 )
CreateConVar( "cb_radar", 1, FCVAR_ARCHIVE, "Controls radar's drawing. 0 is old radar (pre-xbox-series x showcase), 1 - is the new one", 0, 1 )