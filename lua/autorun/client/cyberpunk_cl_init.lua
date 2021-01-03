hook.Add("AddToolMenuCategories", "CyberPunkAdd", function() 
	spawnmenu.AddToolCategory("Options", "CyberPunkMenu", "#CyberPunk HUD")
end)
hook.Add("PopulateToolMenu", "CyberPunkPopulate", function() // Наполняем менюшку
	spawnmenu.AddToolMenuOption("Options", "CyberPunkMenu", "CyberPunkOptions", "#Options", "", "", function(panel)
		panel:ClearControls()
		panel:Help("This is CyberPunk HUD options")
		panel:CheckBox("Enable CyberPunk HUD", "cb_enable")
		panel:CheckBox("Enable Silverhand mode", "cb_johnny")
		panel:CheckBox("Default weapon selection", "cb_selection")
		panel:CheckBox("Enable weapon's icons", "cb_icon")
		panel:CheckBox("Enable new radar style", "cb_radar")
		panel:CheckBox("Enable drawing HUD while death", "cb_drawdead")
		if engine.ActiveGamemode() == "darkrpbase" or engine.ActiveGamemode() == "darkrp" then
			panel:CheckBox("Color pallete by job color", "cb_jobcolor")
			panel:ControlHelp("This is DarkRP only checkbox, it allows you to ovveride HUD's color pallete with your job color")
		end
	end)
end)