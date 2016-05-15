function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability
	local radius = event.Radius
	local fv = -(caster:GetAbsOrigin() - target):Normalized()

	local pid = ParticleManager:CreateParticle("particles/kindra_night_strike/night_strike_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(pid, 1, GetGroundPosition(caster:GetAbsOrigin() + fv * radius * 0.75, nil) + Vector(0, 0, 100))

	local enemies = GetEnemiesInCone(caster, event.Radius, (target - caster:GetAbsOrigin()):Normalized(), 1.4)
	local has_healed = false
	for _, enemy in pairs(enemies) do
		dofile("deal_damage")
		deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, ability, false, false, true)
		Timers:CreateTimer(0.5, function()
			local heal = event.Heal
			if has_healed then
				heal = heal / 2
			else
				has_healed = true
			end
			caster:Heal(event.Heal + find_stat(caster, "power") * event.HealPowerRatio, caster)
		end)
	end
end