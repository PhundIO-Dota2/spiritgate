function think(event)
	local caster = event.caster
	local armour_amnt = caster:GetModifierStackCount("modifier_black_ice", caster) * (6 + find_stat(caster, "power") * 0.075)
	caster:SetModifierStackCount("modifier_black_ice_armour", caster, armour_amnt)
end