CyberPunk = CyberPunk or {}
function CyberPunk.DrawEXPBar(percent) -- Рисовалка exp бара. Туда броня будет писаться.
	local tab1 = {
		{x = width(0.0527), y = height(0.028)},
		{x = width(0.1918), y = height(0.041)},
		{x = width(0.19), y = height(0.047)},
		{x = width(0.0527), y = height(0.035)}
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
		surface.SetDrawColor(255, 	255, 	255, 	255)
		surface.DrawPoly(tab1)
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilFailOperation( STENCIL_KEEP )
		local wanted = isfunction(ply.GetWanted) and LocalPlayer():GetWanted() or isfunction(ply.GetDarkRPVar) and LocalPlayer():GetDarkRPVar "wanted" or isfunction(ply.getDarkRPVar) and LocalPlayer():getDarkRPVar "wanted" or false
		local sin = wanted and math.sin(CurTime()*2) * 100 or 0
		local expcol = CyberPunk.GetColor(2)
		surface.SetDrawColor(124+sin, 154+sin, 148+sin)
		surface.DrawRect(width(0.0527), 0, width(0.1391), height(0.55) )
		surface.SetDrawColor(expcol.r, expcol.g, expcol.b)
		surface.DrawRect(width(0.0527), 0, width(0.1391) * percent, height(0.55) )
	render.SetStencilEnable( false )
end
function CyberPunk.DrawHealthBar(percent, percent1) -- Сам хил бар. Сделал его не полностью попиксельно, тк мелким был сильно.
	local tab = {
		{x = width(0.0528), y = height(0.04)},
		{x = width(0.1919), y = height(0.0536)},
		{x = width(0.1919), y = height(0.062)},
		{x = width(0.1852), y = height(0.069)},
		{x = width(0.0528), y = height(0.054)}
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
		surface.DrawPoly(tab)
	render.SetStencilCompareFunction( STENCIL_EQUAL )
	render.SetStencilFailOperation( STENCIL_KEEP )
		local red = CyberPunk.GetColor(1)
		surface.SetDrawColor(red.r-20, red.g-20, red.b-20)
		surface.DrawRect(width(0.0527), height(0.0316), width(0.1391), height(0.055) )
			surface.SetDrawColor(red.r, red.g, red.b)
			surface.DrawRect(width(0.0527), height(0.0316), width(0.1391) * percent1, height(0.055) )
		surface.SetDrawColor(red.r+20, red.g+20, red.b+20)
		surface.DrawRect(width(0.0527), height(0.0316), width(0.1391) * percent, height(0.055) )
	render.SetStencilEnable( false )
		local size1 = ( #tostring(LocalPlayer():Health()) * (math.Round( height(0.01953125) ) * 0.7) ) / ScrW()
			draw.SimpleText(tostring(LocalPlayer():Health()), "RobotronBlury" .. tostring( math.Round( height(0.01953125) )), width(0.19985), height(0.06640625), red)
			draw.SimpleText(tostring(LocalPlayer():GetMaxHealth()), "RobotronBlury" .. tostring(math.Round( height(0.01302) )), width(0.21 +size1), height(0.06640625), red)
		draw.SimpleText(tostring(LocalPlayer():Health()), "Robotron" .. tostring( math.Round( height(0.01953125) )), width(0.19985), height(0.06640625), red)
		draw.SimpleText(tostring(LocalPlayer():GetMaxHealth()), "Robotron" .. tostring(math.Round( height(0.01302) )), width(0.21 +size1), height(0.06640625), red)
end
function CyberPunk.DrawHealthBarPanel(number) -- Левая панелька с фицеркой. В игре обозначает вроде уровень, в игре фраги (счет игрока)
	draw.NoTexture()
	local wanted = isfunction(ply.GetWanted) and LocalPlayer():GetWanted() or isfunction(ply.GetDarkRPVar) and LocalPlayer():GetDarkRPVar "wanted" or isfunction(ply.getDarkRPVar) and LocalPlayer():getDarkRPVar "wanted" or false
	local sin = wanted and math.sin(CurTime()*2) * 100 or 0
	local blue = CyberPunk.GetColor(2)
	surface.SetDrawColor(blue.r, blue.g, blue.b)
	surface.DrawLine(width(0.0344), height(0.03125), width(0.05051), height(0.03385) )
	surface.DrawLine(width(0.05051), height(0.03385), width(0.05051), height(0.0638))
	surface.DrawLine(width(0.05051), height(0.0638), width(0.040995), height(0.0638) )
	surface.DrawLine(width(0.040995), height(0.0638), width(0.0344), height(0.05208) )
	surface.DrawLine(width(0.0344), height(0.05208), width(0.0344), height(0.03125) )
	local size = math.Clamp( #tostring(number), 2, 32)

		draw.SimpleText(tostring(number), "RobotronBlury" .. tostring( math.Round(height(0.03 / size)) ), width(0.043 ), height(0.036 + #tostring(number) * 0.0015), blue, TEXT_ALIGN_CENTER)
	draw.SimpleText(tostring(number), "Robotron" .. tostring( math.Round(height(0.03 / size)) ), width(0.043 ), height(0.036 + #tostring(number) * 0.0015), blue, TEXT_ALIGN_CENTER)
end
function CyberPunk.DrawAdditionalBar(bars, percent) -- Нижний бар, раньше отвечал за стамину, скоро за доп патроны (и доп метры, например адреналин в Wheatley's parkour)
	draw.NoTexture()
	local blue = CyberPunk.GetColor(2)
	local red = CyberPunk.GetColor(1)
	surface.SetDrawColor(0, 0, 0)
	for i = 0, bars-1 do
		local lerp = 1 - math.Clamp( bars * percent - i, 0, 1)
		local x = width(0.05344) + width(0.0044506) * i
		local y = height(0.05859375) + height(0.00055) * i
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
		--
			surface.DrawRect(x, y, width(0.0035), height(0.016))
		render.SetStencilCompareFunction( STENCIL_EQUAL )
		render.SetStencilFailOperation( STENCIL_KEEP )
			surface.SetDrawColor(blue.r, blue.g, blue.b)
			surface.DrawRect(x, y, width(0.0035), height(0.016))
			surface.SetDrawColor(red.r, red.g, red.b)
			surface.DrawRect(x, y, width(0.0035), height(0.016) * lerp)
		render.SetStencilEnable( false )
	end
end