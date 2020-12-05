CyberPunk = CyberPunk or {}
function CyberPunk.DrawStaminaBar(percent, alpha)
	local tab = {
		{x = width(0.39019), y = height(0.106)},
		{x = width(0.5336749), y = height(0.1080729)},
		{x = width(0.5366032), y = height(0.11197916)},
		{x = width(0.5366032), y = height(0.114583)},
		{x = width(0.532942), y = height(0.1171875)},
		{x = width(0.3931185), y = height(0.114583)},
		{x = width(0.39019), y = height(0.11067708)},
	}
	draw.NoTexture()
	surface.SetDrawColor(235, 196, 61, 255)
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
		surface.SetDrawColor(113, 101, 95, alpha)
		surface.DrawRect(width(0.39019), height(0.10677), width(0.146413), height(0.03))
		surface.SetDrawColor(235, 196, 61, alpha)
		surface.DrawRect(width(0.39019), height(0.10677), width(0.146413) * percent, height(0.03))
	render.SetStencilEnable(false)
end
function CyberPunk.DrawStaminaInfo(drawicon, text, alpha)
	local tab1 = {
		{x = width(0.554905), y = height(0.1158854)},
		{x = width(0.551245), y = height(0.1197916)},
		{x = width(0.545388), y = height(0.1197916)},
		{x = width(0.549780), y = height(0.1158854)},
	}
	local tab2 = {
		{x = width(0.551245), y = height(0.1197916)},
		{x = width(0.554905), y = height(0.1158854)},
		{x = width(0.550512), y = height(0.12630208)},
	}
	local tab3 = {
		{x = width(0.545388), y = height(0.1197916)},
		{x = width(0.551245), y = height(0.109375)},
		{x = width(0.549780), y = height(0.1158854)},
	}
	draw.NoTexture()
	surface.SetDrawColor(235, 196, 61, alpha)
	if drawicon then
		surface.DrawPoly(tab1)
		surface.DrawPoly(tab3)
		surface.DrawPoly(tab2)
	end
	draw.SimpleText(text, "RobotronBlury" .. tostring(math.Round(height(0.0085))), width(0.563), height(0.116), Color( 175, 126, 11, alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	draw.SimpleText(text, "Robotron" .. tostring(math.Round(height(0.0085))), width(0.563), height(0.116), Color( 235, 196, 61, alpha ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end