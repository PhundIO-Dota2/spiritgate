function tick(event)
	local caster = event.caster
	local item = event.ability

	local stacks = caster:GetAttackRange() * 0.2
	item:ApplyDataDrivenModifier(caster, caster, "modifier_item_insight_bonus_attack_range", {})
	caster:SetModifierStackCount("modifier_item_insight_bonus_attack_range", item, stacks)
end