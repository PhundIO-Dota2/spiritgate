function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local unit = create_dummy(caster)
	local pid = ParticleManager:CreateParticle("particles/nissa_final_flight/final_flight_base.vpcf", PATTACH_CUSTOMORIGIN, unit)

	event.caster:FindAbilityByName("ability_high_huntress_final_flight_return"):SetLevel(event.ability:GetLevel())
	event.caster:SwapAbilities("ability_high_huntress_final_flight", "ability_high_huntress_final_flight_return", false, true)

	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local origin_point = caster:GetAbsOrigin()
	event.ability.direction = 1

	event.ability.hit_targets = { }
	local damage_mult = 1

	Timers:CreateTimer(function()
		if unit:IsNull() then return end
		if event.ability.direction == -1 then
			fv = (unit:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
			if math_distance(unit, caster) < 50 then
				unit:Destroy()
				ParticleManager:DestroyParticle(pid, false)
				return
			end
		end
		unit:SetAbsOrigin(unit:GetAbsOrigin() + fv * 34 * event.ability.direction)
		if math_distance(unit:GetAbsOrigin(), origin_point) > 1900 then
			event.ability.direction = -1
			event.ability.hit_targets = { }
			event.caster:SwapAbilities("ability_high_huntress_final_flight", "ability_high_huntress_final_flight_return", true, false)
		end
		ParticleManager:SetParticleControl(pid, 0, unit:GetAbsOrigin() + Vector(0, 0, 10))

		local targets = GetEnemiesInRadius(unit, 222)
		for k, target in ipairs(targets) do
			if not tableContains(event.ability.hit_targets, target) then
				event.ability.hit_targets[#event.ability.hit_targets + 1] = target
				damage_mult = math.max(0.5, damage_mult - 0.1)
				deal_damage(caster, target, event.Damage * damage_mult, event.DamagePowerRatio * damage_mult, 1, event.ability, false, false, true)
			end
		end
		
		return 1 / 30
	end)
	Timers:CreateTimer(15, function()
		if not unit:IsNull() then
			unit:Destroy()
			ParticleManager:DestroyParticle(pid, false)
		end
	end)
end

function recast(event)
	local ability = event.caster:FindAbilityByName("ability_high_huntress_final_flight")
	ability.direction = -1
	ability.hit_targets = { }
	event.caster:SwapAbilities("ability_high_huntress_final_flight", "ability_high_huntress_final_flight_return", true, false)
end