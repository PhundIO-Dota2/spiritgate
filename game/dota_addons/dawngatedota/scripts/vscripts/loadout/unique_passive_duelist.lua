function attack_landed(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, target, "modifier_unique_passive_waystone_duelist_mark", {})
	local new_stacks = math.min(3, target:GetModifierStackCount("modifier_unique_passive_waystone_duelist_mark", caster) + 1)
	target:SetModifierStackCount("modifier_unique_passive_waystone_duelist_mark", caster, new_stacks)

	local damage = 5 + 9 * caster:GetLevel() / 20 + 0.03 * find_stat(caster, "power")
	damage = damage * new_stacks

	dofile("deal_damage")
	deal_damage(caster, target, damage, 0, 2, ability, false, false, false)
end