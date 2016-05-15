function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local ground_target_pid = ParticleManager:CreateParticle("particles/guardian/guardian_fire_circle_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(ground_target_pid, 0, GetGroundPosition(target, nil) + Vector(0, 0, 1))
	local done = false

	local laser_pid = ParticleManager:CreateParticle("particles/guardian/guardian_fire_circle_beam_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(laser_pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 200))
	ParticleManager:SetParticleControl(laser_pid, 1, target + Vector(0, 0, 10))

	StartAnimation(caster, { duration=1, activity=ACT_DOTA_SPAWN, rate=3 }) 

	Timers:CreateTimer(1.5, function()
		StartAnimation(caster, { duration=1, activity=ACT_DOTA_SPAWN, rate=0.25 }) 

		Timers:CreateTimer(function()
			if done then return end
			local targets = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
			for k, target in ipairs(targets) do
				deal_damage(caster, target, event.Damage / 30 / event.Duration, event.DamagePowerRatio / 30 / event.Duration, 2, event.ability, true, false, true)
			end
			return 1 / 30
		end)

		Timers:CreateTimer(event.Duration + 1.3, function()
			ParticleManager:DestroyParticle(laser_pid, false)
		end)
		Timers:CreateTimer(event.Duration + 1.5, function()
			ParticleManager:DestroyParticle(ground_target_pid, false)
			done = true
	    end)
	end)
end