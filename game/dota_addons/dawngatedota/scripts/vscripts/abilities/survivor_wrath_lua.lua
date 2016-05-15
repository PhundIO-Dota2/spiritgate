function on_attack_landed(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target

	local health_percent = 1 - target:GetHealth() / target:GetMaxHealth()

	local damage = event.Damage * health_percent
	local power_ratio = event.DamagePowerRatio * health_percent

	deal_damage(caster, target, damage, power_ratio, 1, event.ability, false, false, false)
end