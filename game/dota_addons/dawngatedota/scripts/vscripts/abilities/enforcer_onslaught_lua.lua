function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local ability = event.ability
	local target_point = event.target_points[1]

	local revolt_ability = caster:FindAbilityByName("ability_enforcer_revolt")
	revolt_ability:ApplyDataDrivenModifier(caster, caster, "modifier_revolt_bold", {})

	local fv = (target_point - caster:GetAbsOrigin()):Normalized()

	local damage = event.FirstCastDamage
	local damage_power_ratio = event.FirstCastDamagePowerRatio
	local distance_left = 150
	local stun = false

	if ability.is_cast2 then
		damage = event.SecondCastDamage
		damage_power_ratio = event.SecondCastDamagePowerRatio
		distance_left = 275
		ability.is_cast2 = false
		Timers:RemoveTimer(ability.recast_timer)
		ability:StartCooldown(get_ability_cooldown(caster, ability))
		stun = true
	else
		ability.recast_timer = Timers:CreateTimer(3, function()
			ability:StartCooldown(get_ability_cooldown(caster, ability))
			ability.is_cast2 = false
		end)
		ability.is_cast2 = true
		ability:EndCooldown()
	end

	local spd = 40

	local hits = {}

	Timers:CreateTimer(function()
		distance_left = distance_left - spd
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin() + fv * spd, false)

		local enemies = { }
		if ability.is_cast2 then
			enemies = GetEnemiesInCone(caster, 120, fv, 3)
		end
		for k, v in pairs(enemies) do
			if not tableContains(hits, v) then
				hits[#hits + 1] = v
				deal_damage(caster, v, damage, damage_power_ratio, 1, event.ability, false, false, true)
			end
		end

		if distance_left < 0 then
			if not ability.is_cast2 then
				enemies = GetEnemiesInRadius(caster, 200)
				for k, v in pairs(enemies) do
					if not tableContains(hits, v) then
						hits[#hits + 1] = v
						deal_damage(caster, v, damage, damage_power_ratio, 1, event.ability, false, false, true)
					end
				end
				local pid = ParticleManager:CreateParticle("particles/basko_onslaught/onslaught_second_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 10))
			else
				local pid = ParticleManager:CreateParticle("particles/basko_onslaught/onslaught_first_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
				ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100) + fv * 30)
				ParticleManager:SetParticleControlForward(pid, 0, fv)
				ParticleManager:SetParticleControl(pid, 1, caster:GetAbsOrigin() + fv * 120 + Vector(0, 0, 100))
			end
			return
		end
		return 1 / 30
	end)
end