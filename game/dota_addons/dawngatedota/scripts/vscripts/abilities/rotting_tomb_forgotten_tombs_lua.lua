function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]

	StartAnimation(caster, { duration=0.5, activity=ACT_DOTA_CAST_ABILITY_1, rate=1 }) 

	local final_point = (target - caster:GetAbsOrigin()):Normalized() * event.Range + caster:GetAbsOrigin()

	local step = (target - caster:GetAbsOrigin()):Normalized() * event.Range / 7

	local angle = math.atan2(step:Normalized().x, step:Normalized().y)

	local offset_1 = Vector(math.sin(angle + math.pi / 2) * event.Width / 4.5, math.cos(angle + math.pi / 2) * event.Width / 4.5, 0)
	local offset_2 = Vector(math.sin(angle - math.pi / 2) * event.Width / 4.5, math.cos(angle - math.pi / 2) * event.Width / 4.5, 0)

	local tomb_pid = ParticleManager:CreateParticle("particles/desecrator_forgotten_tombs/rotting_tomb_forgotten_tombs_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(tomb_pid, 0, caster:GetAbsOrigin() + step)
	
	local hit_targets = { }

	local targets = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin() + step, caster:GetTeamNumber(), event.Width / 2)
	for k,v in ipairs(targets) do
		if not tableContains(hit_targets, v) then
			hit_targets[#hit_targets + 1] = v
			knockback_unit(v, v:GetAbsOrigin(), event.KnockupDuration, 0, 225, true)
			deal_damage(caster, v, event.InitialDamage, event.InitialDamagePowerRatio, 2, event.ability, false, false, true)
		end
	end

	for i=2, 7 do
		Timers:CreateTimer((i - 1) * 0.175, function()
			local small_tomb_pid = ParticleManager:CreateParticle("particles/desecrator_forgotten_tombs/rotting_tomb_forgotten_tombs_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
			if i % 2 == 0 then
				ParticleManager:SetParticleControl(small_tomb_pid, 0, caster:GetAbsOrigin() + step * i + offset_1)
			else
				ParticleManager:SetParticleControl(small_tomb_pid, 0, caster:GetAbsOrigin() + step * i + offset_2)
			end

			Timers:CreateTimer(0.1, function()
				targets = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin() + step * i, caster:GetTeamNumber(), event.Width / 2)
				for k,v in ipairs(targets) do
					if not tableContains(hit_targets, v) then
						hit_targets[#hit_targets + 1] = v
						knockback_unit(v, v:GetAbsOrigin(), event.KnockupDuration, 0, 225, true)
						deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
					end
				end
			end)
		end)
	end
end