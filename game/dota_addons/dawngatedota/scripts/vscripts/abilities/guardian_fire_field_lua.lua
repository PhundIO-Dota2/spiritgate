function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local step = -(caster:GetAbsOrigin() - target):Normalized() * 20
	for i=20, 75 do
		local ground_target_pid = ParticleManager:CreateParticle("particles/guardian/guardian_fire_field_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
		ParticleManager:SetParticleControl(ground_target_pid, 0, caster:GetAbsOrigin() + i * step)
		local fv = -(caster:GetAbsOrigin() - target):Normalized()
		ParticleManager:SetParticleControlForward(ground_target_pid, 0, fv)
	end

	StartAnimation(caster, { duration=1, activity=ACT_DOTA_SPAWN, rate=3 }) 

	local done = false

	Timers:CreateTimer(function()
		if done then return end

		local targets = { }
		for i=20, 75 do
			local current_targets = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin() + step * i, caster:GetTeamNumber(), event.Width / 2)
			for k, target in ipairs(current_targets) do
				if not tableContains(targets, target) then
					tableAdd(targets, target)
				end
			end
		end

		local remove_targets = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin() + step * 84, caster:GetTeamNumber(), event.Width / 2)
		for k, target in ipairs(remove_targets) do
			if tableContains(targets, target) then
				table.remove(targets, k)
			end
		end


		for k, target in ipairs(targets) do
			deal_damage(caster, target, event.Damage / 30 / event.Duration, event.DamagePowerRatio / 30 / event.Duration, 2, event.ability, true, false, true)
		end

		return 1 / 30
	end)
	Timers:CreateTimer(event.Duration, function() done = true end)
end