function cerulean_shores_calling(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target
	local casterPos = caster:GetAbsOrigin()
	local targetPos = target:GetAbsOrigin()
	local tx = targetPos.x - casterPos.x
	local ty = targetPos.y - casterPos.y
	local length = math.sqrt(math.pow(tx, 2) + math.pow(ty, 2)) --I have no idea how to create a vector with lua, replace this with vector logic
	casterPos.x = targetPos.x + tx / length * -20
	casterPos.y = targetPos.y + ty / length * -20
	local fv = -(caster:GetAbsOrigin() - casterPos):Normalized()
	casterPos = casterPos - fv * 35

	local start_dist = math_distance(casterPos, caster:GetAbsOrigin())
	local start_z = caster:GetAbsOrigin().z

	local did_play = false

	caster:SetForceAttackTarget(target)

	Timers:CreateTimer(function()
		if not caster:IsAlive() or not target:IsAlive() then
			FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
		end
		if math_distance(caster:GetAbsOrigin(), casterPos) < start_dist / 2 then
			caster:SetAbsOrigin(caster:GetAbsOrigin() + Vector(0, 0, -40))
		else
			caster:SetAbsOrigin(caster:GetAbsOrigin() + Vector(0, 0, 40))
		end	
		local spd = start_dist / 15
		caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
		if not did_play and  math_distance(caster:GetAbsOrigin(), casterPos) < spd * 10 then
			StartAnimation(caster, { duration=1, activity=ACT_DOTA_CAST_ABILITY_4, rate=1 }) 
			did_play = true
		end
		if math_distance(caster:GetAbsOrigin(), casterPos) < spd * 1.5 then
			FindClearSpaceForUnit(caster, casterPos, true)
			caster:SetForceAttackTarget(nil)

			local heal_minimum = event.HealthRestoredMinimum + event.HealthRestoredMinimumRatio * caster:GetMaxHealth() / 100
			local heal_maximum = event.HealthRestoredMaximum + event.HealthRestoredMaximumRatio * caster:GetMaxHealth() / 100

			local heal_position = math.min(1, (1 - target:GetHealth() / caster:GetMaxHealth()) * 1.2)
			local heal_range = heal_maximum - heal_minimum
			local heal_offset = heal_range * heal_position
			local heal_amount = heal_offset + heal_minimum

			deal_damage_heal(caster, caster, heal_amount, 0, 0)

			deal_damage(caster, target, event.Damage, event.PowerRatio, 1, event.ability, false, false, false)

			return nil
		end
		return 1 / 30
	end)

end