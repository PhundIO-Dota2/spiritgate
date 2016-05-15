function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]

	local spd = 38

	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local distance = 0
	local is_throwing = true

	local pid1 = ParticleManager:CreateParticle("particles/basko_uprising/uprising_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pid2 = ParticleManager:CreateParticle("particles/basko_uprising/uprising_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local axe_pos = caster:GetAbsOrigin()

	local damage_min = event.MinimumDamage
	local damage_max = event.MaximumDamage
	local damage_min_ratio = event.MinimumDamagePowerRatio
	local damage_max_ratio = event.MaximumDamagePowerRatio

	local revolt_ability = caster:FindAbilityByName("ability_enforcer_revolt")
	revolt_ability:ApplyDataDrivenModifier(caster, caster, "modifier_revolt_bold", {})

	Timers:CreateTimer(function()
		if is_throwing then
			distance = distance + spd
			axe_pos = axe_pos + fv * spd
			local targets = GetEnemiesInRadiusOfPoint(axe_pos, caster:GetTeamNumber(), 100)
			local enemy = nil
			for _, target in pairs(targets) do
				if target:IsHero() then
					enemy = target
					break
				end
			end
			if enemy ~= nil then
				ParticleManager:DestroyParticle(pid1, false)
				ParticleManager:DestroyParticle(pid2, false)

				Timers:CreateTimer(function()
					caster:SetAbsOrigin((caster:GetAbsOrigin() * 3 + enemy:GetAbsOrigin()) / 4)
					if math_distance(caster, enemy) < 120 then
						FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
						local damage_percentage = math.min(1, (1 - enemy:GetHealth() / enemy:GetMaxHealth()) * 1 / 0.75)
						
						local damage_range = damage_max - damage_min
						local damage_offset = damage_range * damage_percentage
						local final_damage = damage_min + damage_offset

						local damage_ratio_range = damage_max_ratio - damage_min_ratio
						local damage_ratio_offset = damage_ratio_range * damage_percentage
						local final_ratio_damage = damage_min_ratio + damage_ratio_offset

						deal_damage(caster, enemy, final_damage, final_ratio_damage, 1, event.ability, false, false, false)

						local hit_pid = ParticleManager:CreateParticle("particles/basko_uprising/uprising_hit.vpcf", PATTACH_CUSTOMORIGIN, nil)
						ParticleManager:SetParticleControl(hit_pid, 0, enemy:GetAbsOrigin())

						if event.ability.recast_timer ~= nil then
							Timers:RemoveTimer(event.ability.recast_timer)
						end

						local time_waited = 0
						Timers:CreateTimer(function()
							time_waited = time_waited + 1 / 30
							if not enemy:IsAlive() then
								event.ability:EndCooldown()
								event.ability.recast_timer = Timers:CreateTimer(10, function()
									event.ability:StartCooldown(get_ability_cooldown(caster, event.ability))
									event.ability.recast_timer = nil
								end)
								return
							end
							if time_waited > 30 * 3 then
								return
							end
							return 1 / 30
						end)

						return
					end
					return 1 / 30
				end)
				return false
			end
			if distance >= event.Range then
				is_throwing = false
			end
		else
			fv = (caster:GetAbsOrigin() - axe_pos):Normalized()
			distance = distance - spd
			axe_pos = axe_pos + fv * spd
			if distance <= 0 then
				ParticleManager:DestroyParticle(pid1, false)
				ParticleManager:DestroyParticle(pid2, false)
				return
			end
		end
		local fv_angle = rotate_fv(fv, math.pi / 2)
		ParticleManager:SetParticleControl(pid1, 0, caster:GetAbsOrigin() + fv_angle * 30 + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid2, 0, caster:GetAbsOrigin() - fv_angle * 30 + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid1, 3, axe_pos + fv * 50 + fv_angle * 30 + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid2, 3, axe_pos + fv * 50 + fv_angle * -30 + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid1, 1, axe_pos + fv * 50 + fv_angle * 30 + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid2, 1, axe_pos + fv * 50 + fv_angle * -30 + Vector(0, 0, 100))
		return 1 / 30
	end)
end