function add_stack(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, target, "modifier_pure_shaper_compound_interest_stack", {})
	target:SetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster, target:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) + 1)
	if target:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) >= 4 then
		target:RemoveModifierByName("modifier_pure_shaper_compound_interest_stack")
		dofile("deal_damage")
		deal_damage(caster, target, 20 + 80 * caster:GetLevel() / 20, 0.3, 1, event.ability, false, false, false)
	end 
end