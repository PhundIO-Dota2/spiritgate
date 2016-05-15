function cast(event)
	local caster = event.caster
	local target = event.target
	local unit = create_dummy(caster)
	local pid = ParticleManager:CreateParticle("particles/nissa_branching_blade/branching_blade_base.vpcf", PATTACH_CUSTOMORIGIN, unit)
	local done = false
	Timers:CreateTimer(function()
		if done or not target:IsAlive() or target:IsNull() then 
			unit:Destroy() 
			ParticleManager:DestroyParticle(pid, true) 
			return 
		end
		local fv = (target:GetAbsOrigin() - unit:GetAbsOrigin()):Normalized() 
		unit:SetAbsOrigin(unit:GetAbsOrigin() + fv * 27)
		ParticleManager:SetParticleControl(pid, 0, unit:GetAbsOrigin() + Vector(0, 0, 100))
		if math_distance(unit, target) < 40 then
			deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, false, 0)
			local targets = GetEnemiesInCone(unit, event.Range * 0.60, fv, 1)
			for i = 1, #targets do
				if targets[i] == target then
					table.remove(targets, i)
				end
			end
			local targets_final = { }
			for i=1, 2 do
				if #targets > 0 then 
					local index = RandomInt(1, #targets)
					targets_final[i] = targets[index] 
					table.remove(targets, index)
				end
			end
			for k, target2 in ipairs(targets_final) do
				local done2 = false
				local unit2 = create_dummy(unit)
				local pid2 = ParticleManager:CreateParticle("particles/nissa_branching_blade/branching_blade_branch.vpcf", PATTACH_CUSTOMORIGIN, unit)
				
				Timers:CreateTimer(function()
					if done2 or not target2:IsAlive() or target2:IsNull() then 
						unit2:Destroy() 
						ParticleManager:DestroyParticle(pid2, true) 
						return 
					end
					local fv = (target2:GetAbsOrigin() - unit2:GetAbsOrigin()):Normalized() 
					unit2:SetAbsOrigin(unit2:GetAbsOrigin() + fv * 37)
					ParticleManager:SetParticleControl(pid2, 0, unit2:GetAbsOrigin() + Vector(0, 0, 100))
					if math_distance(unit2, target2) < 40 then
						unit2:Destroy()
						ParticleManager:DestroyParticle(pid2, true) 
						deal_damage(caster, target2, event.SecondaryDamage, event.SecondaryDamagePowerRatio, 1, event.ability, false, false, true, 0)
						return nil
					end
					return 1 / 30
				end)
				Timers:CreateTimer(10, function()
					done2 = true
				end)
			end
			unit:Destroy()
			ParticleManager:DestroyParticle(pid, true) 
			return nil
		end
		return 1 / 30
	end)
	Timers:CreateTimer(10, function()
		done = true
	end)
end