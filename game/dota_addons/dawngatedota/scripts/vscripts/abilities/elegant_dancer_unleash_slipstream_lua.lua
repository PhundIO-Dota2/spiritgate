function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/ashabel_unleash/slipstream_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pos = caster:GetAbsOrigin()
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local distance_travelled = 0

	local spd = 26

	Timers:CreateTimer(function()
		distance_travelled = distance_travelled + spd
		pos = pos + fv * spd
		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 75))
		enemies = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 100)
		for _, enemy in pairs(enemies) do
			deal_damage(caster, enemy, event.Damage * distance_travelled / 1100, event.PowerRatio * distance_travelled / 1100, 2, event.ability, false, false, false)
			distance_travelled = 10000 --Used to kill projectile
			break
		end
		if distance_travelled > 1100 then
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		return 1 / 30
	end)
end