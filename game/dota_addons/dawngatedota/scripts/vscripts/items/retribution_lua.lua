function RetributionAttackLanded(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target
	local item = event.ability

	local damage = caster:GetModifierStackCount("item_retribution_mage_slayer_stacks", item)

	deal_damage(caster, target, damage, 0, 2, "RETRIBUTION", false, false, false, 0)
	caster:RemoveModifierByName("item_retribution_mage_slayer_stacks")
end