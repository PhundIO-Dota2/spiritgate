function tick(event)
	local caster = event.caster
	local ability = event.ability
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_rage_adrenaline_stack", {})
	local stacks = caster:GetModifierStackCount("modifier_rage_adrenaline_stack", caster)
	if stacks < 50 then stacks = stacks + 1 end
	if stacks > 50 then 
		stacks = stacks - 1 
		dofile("deal_damage")
		deal_damage_heal(caster, caster, (3 - 0.72) * ((caster:GetLevel() - 1) / 19) + 0.72, 0, 0)
	end
	caster:SetModifierStackCount("modifier_rage_adrenaline_stack", caster,	stacks)
end

function attack_landed(event)
	local caster = event.caster
	local ability = event.ability
	caster:SetModifierStackCount("modifier_rage_adrenaline_stack", caster,	math.min(100, caster:GetModifierStackCount("modifier_rage_adrenaline_stack", caster) + 10))
end