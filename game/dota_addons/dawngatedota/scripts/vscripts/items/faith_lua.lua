function add_stack(event)
	local caster = event.caster
	local item = event.ability
	
	item:ApplyDataDrivenModifier(caster, caster, "modifier_arcane_aegis", {})
	caster:SetModifierStackCount("modifier_arcane_aegis", caster, math.min(375, caster:GetModifierStackCount("modifier_arcane_aegis", caster) + 25))
end