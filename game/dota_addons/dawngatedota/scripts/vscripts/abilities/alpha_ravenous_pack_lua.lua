function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local wolves = { }
	for i=1, 5 do
		wolves[i] = create_dummy(caster)
		wolves[i].pid = ParticleManager:CreateParticle("particles/fenmore_heart_eater/heart_eater_base.vpcf", PATTACH_CUSTOMORIGIN, wolves[i])
		
		wolves[i].is_lunging = false
	end
	local done = false
	local angle = 0
	Timers:CreateTimer(function()
		if done then
			for i=1, 5 do
				local wolf = wolves[i]
				wolf:Destroy()
			end
			return nil
		end
		angle = angle + 0.1
		for i=1, 5 do
			local wolf = wolves[i]
			if not wolf.is_lunging then
				local new_angle = angle + (math.pi * 2) / 5 * i
				while new_angle > math.pi * 2 do new_angle = new_angle - math.pi * 2 end
				local old_origin = wolf:GetAbsOrigin()
				local target_pos = caster:GetAbsOrigin() + 200 * Vector(math.cos(new_angle), math.sin(new_angle), 0)
				wolf:SetAbsOrigin((wolf:GetAbsOrigin() * 6 + target_pos) / 7)
				ParticleManager:SetParticleControl(wolf.pid, 0, wolf:GetAbsOrigin())
				ParticleManager:SetParticleControl(wolf.pid, 1, wolf:GetAbsOrigin() + 75 * Vector(math.cos(new_angle + 90 / 180 * math.pi), math.sin(new_angle + 90 / 180 * math.pi), 0))
			end
		end
		return 1 / 30
	end)
	Timers:CreateTimer(0.25, function()
		local hit_targets = { }
		local used_wolves = { false, false, false, false, false }
		local done_wolf_attack_zone = false
		Timers:CreateTimer(function()
			if not done_wolf_attack_zone then
				for i=1, 5 do
					if not used_wolves[i] then
						local wolf = wolves[i]
						if wolf:IsNull() then return end
						local targets = GetEnemiesInRadius(wolf, 500)
						for k, target in ipairs(targets) do 
							if not tableContains(hit_targets, target) then
								hit_targets[#hit_targets + 1] = target
								wolf.is_lunging = true
								used_wolves[i] = true
								Timers:CreateTimer(function()
									if wolf:IsNull() then return end
									if not wolf.is_lunging then return end
									local fv = (target:GetAbsOrigin() - wolf:GetAbsOrigin()):Normalized()
									wolf:SetAbsOrigin(wolf:GetAbsOrigin() + fv * 34)
									ParticleManager:SetParticleControl(wolf.pid, 0, wolf:GetAbsOrigin())
									ParticleManager:SetParticleControl(wolf.pid, 1, wolf:GetAbsOrigin() + fv * 100)
									if math_distance(wolf, target) < 80 then
										wolf.is_lunging = false
										deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
										return nil
									end
									return 1 / 30
								end)
								Timers:CreateTimer(0.75, function()
									if wolf:IsNull() then return end
									wolf.is_lunging = false
								end)
								break
							end
						end
					end
				end
			end
			return 1 / 30
		end)
		Timers:CreateTimer(0.25, function()
			done_wolf_attack_zone = true
		end)
		return 1
	end)
	Timers:CreateTimer(5, function()
		done = true
	end)
end