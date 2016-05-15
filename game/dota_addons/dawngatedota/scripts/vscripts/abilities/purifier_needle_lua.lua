function cast(event)
	local caster = event.caster

	if caster:GetHealth() <= event.HealthCost + 1 then 
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return 
	end

	caster:SetHealth(caster:GetHealth() - event.HealthCost)

	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/viyanna_needle/needle_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pos = caster:GetAbsOrigin()
	local distance = 0
	local fv = -(caster:GetAbsOrigin() - target):Normalized()
	local spd = 32

	ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(pid, 1, pos + fv * spd + Vector(0, 0, 100))

	Timers:CreateTimer(function()
		pos = pos + fv * spd
		distance = distance + spd

		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid, 1, pos + fv * spd + Vector(0, 0, 100))

		hits = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 70)
		for k, hit in pairs(hits) do
			dofile("deal_damage")
			deal_damage(caster, hit, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, false)
			create_heal_globe(event, pos, false)
			if(hit:IsHero()) then
				create_heal_globe(event, pos, true)
			end
			ParticleManager:DestroyParticle(pid, false)
			return
		end

		if distance > event.Range then
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		return 1 / 30
	end)
end

function create_heal_globe(event, pos, skip_first)
	local targets = GetFriendyHeroesInRadiusOfPoint(pos, event.caster:GetTeamNumber(), 1200)
	if #targets >= 1 and (#targets >= 2 or not skip_first) then
		local target = targets[1]
		if skip_first then
			target = targets[2]
		end
		local pid = ParticleManager:CreateParticle("particles/purity/purityblob_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		local pid_pos = pos * Vector(1, 1, 1) --Make a new instance? maybe?
		pid_pos = GetGroundPosition(pid_pos, nil) + Vector(0, 0, 100)
		ParticleManager:SetParticleControl(pid, 0, pid_pos)
		Timers:CreateTimer(function()
			pid_pos = pid_pos + ((target:GetAbsOrigin() + Vector(0, 0, 100)) - pid_pos):Normalized() * 34
			ParticleManager:SetParticleControl(pid, 0, pid_pos)
			if (pid_pos - target:GetAbsOrigin()):Length2D() < 50 then
				deal_damage_heal(event.caster, target, event.Heal, 0, event.HealHealthRatio)
				ParticleManager:DestroyParticle(pid, false)
				return
			end
			return 1 / 30
		end)
	end
end