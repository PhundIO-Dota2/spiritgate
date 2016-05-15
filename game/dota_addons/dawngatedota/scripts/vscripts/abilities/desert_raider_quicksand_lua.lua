function cast(event)
	local caster = event.caster
	local target_point = event.target_points[1]
	local ability = event.ability
	local spirit_sand_ability = caster:GetAbilityByIndex(0)

	local done = false

	local pid = ParticleManager:CreateParticle("particles/kahgen_quicksand/quicksand_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target_point)

	Timers:CreateTimer(function()
		if done then return end

		local targets = GetEnemiesInRadiusOfPoint(target_point, caster:GetTeamNumber(), event.Radius)
		for k, target in ipairs(targets) do
			ability:ApplyDataDrivenModifier(caster, target, "modifier_desert_raider_quicksand", { Duration = 0.1 })
			ability:ApplyDataDrivenModifier(caster, target, "modifier_desert_raider_quicksand_stack", { Duration = 0.1 })
			local upper = event.MaxMovementSpeedSlow - event.MinMovementSpeedSlow
			local offset = event.Radius / (event.Radius - math_distance(target_point, target:GetAbsOrigin()))
			local total = upper / offset + event.MinMovementSpeedSlow
			target:SetModifierStackCount("modifier_desert_raider_quicksand_stack", caster, -total)
		end
		return 1 / 30
	end)
	Timers:CreateTimer(0.1, function()
		if done then return end

		local targets = GetEnemiesInRadiusOfPoint(target_point, caster:GetTeamNumber(), event.Radius)
		for k, target in ipairs(targets) do
			spirit_sand_ability:ApplyDataDrivenModifier(caster, target, "modifier_spirit_sand", {})
			target:SetModifierStackCount("modifier_spirit_sand", caster, target:GetModifierStackCount("modifier_spirit_sand", caster) + 1)
		end
		return 1
	end)
	Timers:CreateTimer(event.Duration, function()
		done = true
		ParticleManager:DestroyParticle(pid, false)
	end)
end