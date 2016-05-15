function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]

	local up_pid = ParticleManager:CreateParticle("particles/vex_jagged_volley/jagged_volley_up_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(up_pid, 0, caster:GetAbsOrigin())
	Timers:CreateTimer(0.4, function()
		local down_pid = ParticleManager:CreateParticle("particles/vex_jagged_volley/jagged_volley_hitground_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(down_pid, 0, target + Vector(0, 0, 1))

		Timers:CreateTimer(0.4, function()
			local hits = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
			for _, enemy in pairs(hits) do
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
			end

			local targets_in_radius = { }
			local time_left = event.Duration * 30
			Timers:CreateTimer(function()
				local old_targets = targets_in_radius
				targets_in_radius = { }
				local hits = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
				for _, hit in pairs(hits) do
					event.ability:ApplyDataDrivenModifier(caster, hit, "modifier_jagged_volley_slow", {})
					if not tableContains(targets_in_radius, hit) then
						targets_in_radius[#targets_in_radius + 1] = hit
					end
				end
				for _, hit in pairs(old_targets) do
					if not tableContains(targets_in_radius, hit) then
						hit:RemoveModifierByName("modifier_jagged_volley_slow")
					end
				end

				time_left = time_left - 1
				if time_left <= 0 then
					for _, hit in pairs(targets_in_radius) do
						hit:RemoveModifierByName("modifier_jagged_volley_slow")
					end
					return
				end
				return 1 / 30
			end)
		end)
	end)
end