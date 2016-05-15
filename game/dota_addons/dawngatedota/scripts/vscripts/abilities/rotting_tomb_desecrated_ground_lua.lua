function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	local persisting = true
	local slowing = { }

	local pid = ParticleManager:CreateParticle("particles/desecrator_desecrated_ground/desecrated_ground_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target)

	StartAnimation(caster, { duration=0.5, activity=ACT_DOTA_CAST_ABILITY_3, rate=1 }) 

	Timers:CreateTimer(function() --slow
		if not persisting then 
			for k, v in ipairs(slowing) do
				v:RemoveModifierByName("modifier_desecrated_ground_slow")
			end
			return 
		end
		local targets = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
		for k, v in ipairs(targets) do
			if not tableContains(slowing, v) then
				ability:ApplyDataDrivenModifier(caster, v, "modifier_desecrated_ground_slow", {})
				slowing[#slowing + 1] = v
			end
		end
		for k, v in ipairs(slowing) do
			if not tableContains(targets, v) then
				table.remove(slowing, k)
				v:RemoveModifierByName("modifier_desecrated_ground_slow")
			end
		end
		return 1/ 15
	end)
	Timers:CreateTimer(1.2, function() --root
		--modifier_desecrated_ground_root
		local targets = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
		for k, v in ipairs(targets) do
			disable({
				caster = caster,
				target = v,
				Duration = event.RootDuration,
				DisableModifier = "modifier_desecrated_ground_root",
				ability = event.ability
			})
			deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
		end
	end)
	Timers:CreateTimer(event.PersistDuration, function() --end persist
		persisting = false
	end)
end