function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/ashabel_wrath_of_the_heaven/wrath_of_the_heaven_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target + Vector(0, 0, 50))

	local marker = ParticleManager:CreateParticle("particles/radius_indicator/radius_indicator.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(marker, 0, target + Vector(0, 0, 10))
	ParticleManager:SetParticleControl(marker, 1, Vector(event.Radius, 2, 1))

	Timers:CreateTimer(event.Delay - 1.3, function()
		Timers:CreateTimer(1.7, function()
			local enemies = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
			for _, enemy in pairs(enemies) do
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
			end
		end)
		AddFOWViewer(caster:GetTeamNumber(), target, event.Radius, 2.4, true)
	end)
end