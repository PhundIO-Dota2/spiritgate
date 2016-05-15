function cast(event)

	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	if ability.casts == nil then ability.casts = 0 end
	if ability.targets == nil then ability.targets = { } end
	if ability.total_damage_table == nil then ability.total_damage_table = { } end

	local ground_pid = -1

	ability.casts = ability.casts + 1
	local cast = ability.casts

	local kill_fog = false
	Timers:CreateTimer(function() --Target Finder Ticker
		if kill_fog then 
			return
		end
		ability.targets[cast] = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.Radius)
		return 1 / 15
	end)

	launch_zombie_pid(event)

	Timers:CreateTimer(0.5, function()
		ground_pid = ParticleManager:CreateParticle("particles/desecrator_deathfog/deathfog_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(ground_pid, 0, target)
	end)

	Timers:CreateTimer(event.Duration, function() --Duration End Ticker
		kill_fog = true
		ParticleManager:DestroyParticle(ground_pid, true)
		ability.targets[cast] = nil
	end)

	StartAnimation(caster, { duration=0.5, activity=ACT_DOTA_CAST_ABILITY_4, rate=1 }) 

	if ability.casts == 1 then
		local timeout_ticker = nil
		local started_3_cast_tickout = false
		Timers:CreateTimer(function() --Damage Ticker
			if not started_3_cast_tickout and ability.casts == 3 then
				ability:StartCooldown(get_ability_cooldown(caster, ability)) --No more recasts, start cooldown
				Timers:CreateTimer(event.Duration, function() --Reset Ticker
					ability.casts = 0
					ability.targets = { }
					if timeout_ticker ~= nil then
						Timers:RemoveTimer(timeout_ticker)
					end
				end)
				started_3_cast_tickout = true
			end
			if ability.casts == 0 then
				return
			end

			local total_percent = event.DamageOfMaximumHealth + event.DamagePowerRatioOfMaximumHealth * find_stat(caster, "power")
			local hit_targets = { }
			for i=1, 3 do
				if ability.targets[i] ~= nil then
					for k, target in ipairs(ability.targets[i]) do
						if not tableContains(hit_targets, target) then
							hit_targets[#hit_targets + 1] = target
							local damage = target:GetMaxHealth() * total_percent / 100 / 30
							if ability.total_damage_table[target] == nil then ability.total_damage_table[target] = 0 end
							ability.total_damage_table[target] = ability.total_damage_table[target] + damage
							if target:IsHero() or ability.total_damage_table[target] < event.MaxDamageAgainstNonShaper then
								deal_damage(caster, target, damage, 0, 2, event.ability, true, false, true)
							end
						end
					end
				end
			end

			return 1 / 30
		end)
		timeout_ticker = Timers:CreateTimer(15, function() --Recast timeout ticker
			if not started_3_cast_tickout then
				ability.casts = 3
				timeout_ticker = nil
			end
		end)
	end

	ability:EndCooldown()
end

function launch_zombie_pid(event)
	local caster = event.caster
	local target = event.target_points[1]

	local direction = 1

	local dead = false
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local zombie_pos = caster:GetAbsOrigin() + fv * 80
	local spd = math_distance(zombie_pos, target) / 16

	local zombie_pid = ParticleManager:CreateParticle("particles/desecrator_deathfog/deathfog_zombie.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(zombie_pid, 0, target)
	Timers:CreateTimer(0.5, function()
		ParticleManager:DestroyParticle(zombie_pid, true)
		dead = true
	end)
	Timers:CreateTimer(0.25, function()
		direction = -1
	end)
	Timers:CreateTimer(function() 
		if dead then return end
		zombie_pos = zombie_pos + fv * spd + Vector(0, 0, direction * 150)
		ParticleManager:SetParticleControl(zombie_pid, 0, zombie_pos)
		return 1 / 30
	end)
end