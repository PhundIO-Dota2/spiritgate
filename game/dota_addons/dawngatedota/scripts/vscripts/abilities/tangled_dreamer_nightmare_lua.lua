function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/dibs_nightmare/dibs_nightmare_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target)
	Timers:CreateTimer(0.3, function()
		local enemies = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)

		for _, enemy in ipairs(enemies) do
			deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
			event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_bad_dreams", {})
			enemy.bad_dreams_damage = event.BadDreamsDamage + find_stat(caster, "power") * event.BadDreamsDamagePowerRatio
			local pid_2 = ParticleManager:CreateParticle("particles/dibs_nightmare/nightmare_debuff_hit.vpcf", PATTACH_CUSTOMORIGIN, nil) 
			ParticleManager:SetParticleControl(pid_2, 0, enemy:GetAbsOrigin())
		end
	end)
end