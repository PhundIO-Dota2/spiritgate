function tick_pyre(event)
	local caster = event.caster
	local target = event.target
	dofile("deal_damage")

	local stacks = target:GetModifierStackCount("modifier_pride_shaper_pyre", caster)

	deal_damage(caster, target, 8 / 10 * stacks, 0.05 / 8 * stacks, 2, event.ability, true, false, false)
end