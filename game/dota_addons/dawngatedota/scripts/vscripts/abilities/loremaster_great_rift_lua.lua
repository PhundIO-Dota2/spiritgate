function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	dofile("deal_damage")
	local pid = ParticleManager:CreateParticle("particles/zalgus_great_rift/great_rift_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target)
	Timers:CreateTimer(1, function()
		local enemies = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
		for _, enemy in ipairs(enemies) do
			deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
		end
	end)
end