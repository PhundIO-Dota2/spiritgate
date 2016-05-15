function OnAttackLandedAftermath(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	caster:RemoveModifierByName("item_conquest_aftermath")
	deal_damage(caster, target, 50, 1.2, 1, "CONQUEST", false, false, false)
end