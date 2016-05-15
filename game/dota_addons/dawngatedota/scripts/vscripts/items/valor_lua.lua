function tick(event)
	local caster = event.caster
	local item = event.ability

	local stacks = (1 - caster:GetHealth() / caster:GetMaxHealth()) * 40
	if stacks > 0 then
		item:ApplyDataDrivenModifier(caster, caster, "modifier_valor_power", {})
		caster:SetModifierStackCount("modifier_valor_power", caster, stacks)
	else
		caster:RemoveModifierByName("modifier_valor_power")
	end
end