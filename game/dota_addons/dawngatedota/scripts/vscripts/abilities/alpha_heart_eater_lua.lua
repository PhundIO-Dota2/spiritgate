function cast(event)
	dofile("deal_damage")
	local caster = event.caster

	if caster:GetHealth() <= event.HealthCost + 1 then 
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return 
	end
	
	caster:SetHealth(caster:GetHealth() - event.HealthCost)
	
	
	local target = event.target_points[1]
	local wolf = caster:GetAbsOrigin()
	local pid = ParticleManager:CreateParticle("particles/fenmore_heart_eater/heart_eater_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	
	local return_pid = ParticleManager:CreateParticle("particles/fenmore_heart_eater/heart_eater_paw_base.vpcf", PATTACH_CUSTOMORIGIN, caster)

	--"particles/testpart.vpcf"
	--"particles/fenmore_heart_eater/heart_eater_base.vpcf"
	--"particles/econ/items/luna/luna_crescent_moon/luna_glaive_bounce_crescent_moon.vpcf"
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local origin = caster:GetAbsOrigin()

	ParticleManager:SetParticleControl(return_pid, 0, origin - fv * 500)
	ParticleManager:SetParticleControl(return_pid, 1, origin)
	ParticleManager:SetParticleControl(pid, 0, wolf)
	ParticleManager:SetParticleControl(pid, 1, wolf + fv * 100)

	local hit_targets = { }
	local heal_amount = 0
	local did_turn = false

	Timers:CreateTimer(function()
		if not did_turn and math_distance(origin, wolf) > 850 then
			fv = -fv
			hit_targets = { }
			did_turn = true
		end	
		local hits = GetEnemiesInRadiusOfPoint(wolf, caster:GetTeamNumber(), 130)
		for k, hit in ipairs(hits) do
			if not tableContains(hit_targets, hit) then
				hit_targets[#hit_targets + 1] = hit
				local damage_dealt = deal_damage(caster, hit, event.Damage, event.PowerRatio, 2, event.ability, false, false, true)
				if hit:IsHero() then
					heal_amount = heal_amount + damage_dealt * 0.5
				else
					heal_amount = heal_amount + damage_dealt * 0.1
				end
			end
		end
		if did_turn and math_distance(caster:GetAbsOrigin(), wolf) < 130 then
			deal_damage_heal(caster, caster, heal_amount, 0, 0)
			ParticleManager:DestroyParticle(pid, false)
			ParticleManager:DestroyParticle(return_pid, false)
			return
		end
		wolf = wolf + fv * 30
		wolf = GetGroundPosition(wolf, nil)
		ParticleManager:SetParticleControl(pid, 0, wolf)
		ParticleManager:SetParticleControl(pid, 1, wolf + fv * 100)
		return 1 / 30
	end)
	Timers:CreateTimer(2.5, function()
		ParticleManager:DestroyParticle(pid, false)
	end)
end
