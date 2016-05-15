function cast(event)
	local caster = event.caster
	local target_point = event.target_points[1]

	local spd = 49
	local fv = (target_point - caster:GetAbsOrigin()):Normalized()
	local distance_left = event.Range

	local skewer_target = nil

	local pid = ParticleManager:CreateParticle("particles/viridian_deep_rising/deep_rising_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(pid, 1, caster:GetAbsOrigin() + fv * event.Range)

	Timers:CreateTimer(function()
		caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
		caster:SetAbsOrigin(GetGroundPosition(caster:GetAbsOrigin(), caster))
		distance_left = distance_left - spd
		caster:Stop()
		local distance_passed = event.Range - distance_left


		local skewer_target_choices = GetEnemiesInCone(caster, 200, fv, 2)
		for _, skewer_target_choice in pairs(skewer_target_choices) do
			if skewer_target_choice:IsHero() then
				if skewer_target == nil then
					skewer_target = skewer_target_choice
				end
				if skewer_target_choice ~= skewer_target then
					knockback_unit(skewer_target_choice, caster:GetAbsOrigin(), 0.5, 100, 150, false)
				end
			end
			break
		end
		if skewer_target ~= nil then
			skewer_target:SetAbsOrigin(caster:GetAbsOrigin() + spd * 2 * fv + Vector(0, 0, distance_passed * 1.5 - (1.5/event.Range) * distance_passed * distance_passed) + fv * 100)
			skewer_target:Stop()
		end
		caster:SetAbsOrigin(caster:GetAbsOrigin() + Vector(0, 0, distance_passed * 1.5 - (1.5/event.Range) * distance_passed * distance_passed))

		if distance_left <= 0 then
			FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
			if skewer_target then
				FindClearSpaceForUnit(skewer_target, skewer_target:GetAbsOrigin(), false)
				dofile("deal_damage")
				deal_damage(caster, skewer_target, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, false)
			end
			return
		end
		return 1 / 30
	end)
end