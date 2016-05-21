function tick_consumption_damage(event)
	local caster = event.caster
	local target = event.target

	dofile("deal_damage")

	local ratio = 0.03 + 0.0015 * find_stat(caster, "power")
	local damage = caster:GetMaxHealth() * ratio / 20

	if not target:IsHero() then
		damage = damage / 2
		if target.consumption_damage == nil then target.consumption_damage = 0 end
		target.consumption_damage = target.consumption_damage + damage
		if target.consumption_damage > 46 then
			damage = math.max(0, damage - target.consumption_damage)
			target.consumption_damage = 46
		end
	end

	deal_damage_heal(caster, caster, damage / 2, 0, 0)

	deal_damage(caster, target, damage, 0, DAMAGE_TYPE_MAGICAL, event.ability, true, false, false)
end