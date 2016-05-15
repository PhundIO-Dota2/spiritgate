function tick(event)
	local caster = event.caster
	local ability = event.ability
	local stacks = (100 - caster:GetHealth() / caster:GetMaxHealth() * 100) * (0.2 + (caster:GetLevel() * 0.064))
	if stacks > 0 then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_health_shaper_power", {})
		caster:SetModifierStackCount("modifier_health_shaper_power", ability, stacks)
	else
		caster:RemoveModifierByName("modifier_health_shaper_power")
	end
end