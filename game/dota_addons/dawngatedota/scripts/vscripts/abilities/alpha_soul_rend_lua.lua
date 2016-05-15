function cast(event)
	local caster = event.caster
	
	local target = event.target
	local dummy = create_dummy(caster)
	dummy:SetAbsOrigin(target:GetAbsOrigin())
	local pid = ParticleManager:CreateParticle("particles/fenmore_soul_rend/soul_base.vpcf", PATTACH_CUSTOMORIGIN, dummy)
	ParticleManager:SetParticleControl(pid, 0, dummy:GetAbsOrigin())
	local pid_area = ParticleManager:CreateParticle("particles/fenmore_soul_rend/soul_pickup_area.vpcf", PATTACH_CUSTOMORIGIN, dummy)
	ParticleManager:SetParticleControl(pid_area, 0, dummy:GetAbsOrigin())
	Timers:CreateTimer(0.2, function()
		if dummy:IsNull() then return end
		if math_distance(dummy, caster) < 325 then
			dummy:Destroy()
			dofile("modifier_helper")
			AddStacks({
				caster = caster,
				target = caster,
				ability = event.ability,
				IsUniversalModifier = "True",
				Stacks = event.ShieldAmount + event.ShieldAmountPowerRatio * find_stat(caster, "power"),
				MaxStacks = 1000000,
				ModifierName = "modifier_universal_shield",
				Duration = event.Duration
			})
			local shield_pid = ParticleManager:CreateParticle("particles/fenmore_soul_rend/soul_rend_shield_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
			local done = false
			Timers:CreateTimer(function()
				if done then return end
				ParticleManager:SetParticleControl(shield_pid, 0, caster:GetAbsOrigin())
				return 1 / 30
			end)
			Timers:CreateTimer(event.Duration, function()
				ParticleManager:DestroyParticle(shield_pid, false)
				done = true
			end)

			return nil
		end
		return  1 / 15
	end)
	Timers:CreateTimer(3, function()
		if dummy:IsNull() then return end
		dummy:Destroy()
	end)
	ParticleManager:CreateParticle("particles/fenmore_soul_rend/soul_rend_hit_base.vpcf", PATTACH_ROOTBONE_FOLLOW, target)
end