function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local spd = 29
	local fv = -(caster:GetAbsOrigin() - target):Normalized() * spd

	local chain_pid = ParticleManager:CreateParticle("particles/zalgus_chains_of_fate/chains_of_fate_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local chain_pos = caster:GetAbsOrigin()
	local distance = 0

	local shapers_chained = { }
	local enemies_hit = { }
	local first_enemy_hit = nil

	local chain_pids = {

	}

	Timers:CreateTimer(function()
		for k, pid_table in pairs(chain_pids) do
			ParticleManager:SetParticleControl(pid_table[1], 0, pid_table[2]:GetAbsOrigin() + Vector(0, 0, 100))
			ParticleManager:SetParticleControl(pid_table[1], 1, pid_table[3]:GetAbsOrigin() + Vector(0, 0, 100))
		end
		for k, shaper in ipairs(shapers_chained) do
			if math_distance(shaper, first_enemy_hit) > 300 or not shaper:IsAlive() or not first_enemy_hit:IsAlive() then
				shaper.shapers_chained = {}
				table.remove(shapers_chained, k)
				for k2, pid_table in pairs(chain_pids) do
					if pid_table[3] == shaper then
						ParticleManager:DestroyParticle(pid_table[1], false)
						table.remove(chain_pids, k2)
					end
				end
			end
			shaper.shapers_chained = shapers_chained
		end
		if #chain_pids == 0 and distance > event.Range then
			return
		end
		return 1 / 30
	end)

	Timers:CreateTimer(function()
		distance = distance + spd
		if distance > event.Range then
			ParticleManager:DestroyParticle(chain_pid, false)
			return
		end
		local enemies = GetEnemiesInRadiusOfPoint(chain_pos, caster:GetTeamNumber(), 110)
		for _, enemy in pairs(enemies) do
			if not tableContains(enemies_hit, enemy) then
				if enemy:IsHero() then
					if first_enemy_hit == nil then
						first_enemy_hit = enemy
					else
						local sub_chain_pid = ParticleManager:CreateParticle("particles/zalgus_chains_of_fate/chains_effects.vpcf", PATTACH_CUSTOMORIGIN, nil)
						ParticleManager:SetParticleControl(sub_chain_pid, 0, first_enemy_hit:GetAbsOrigin() + Vector(0, 0, 100))
						ParticleManager:SetParticleControl(sub_chain_pid, 1, enemy:GetAbsOrigin() + Vector(0, 0, 100))
						chain_pids[#chain_pids + 1] = {sub_chain_pid, first_enemy_hit, enemy}
					end

					shapers_chained[#shapers_chained + 1] = enemy
					enemy.shapers_chained = shapers_chained
					enemy.loremaster_chainer = caster
					disable({
						caster = caster,
    					target = enemy,
    					Duration = event.RootDuration,
    					DisableModifier = "modifier_chains_of_fate",
    					ability = event.ability,
					})
				end
				enemies_hit[#enemies_hit + 1] = enemy
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true, 0)
			end
		end
		chain_pos = chain_pos + fv
		chain_pos = GetGroundPosition(chain_pos, nil) + Vector(0, 0, 120)
		ParticleManager:SetParticleControl(chain_pid, 0, chain_pos)
		return 1 / 30
	end)
end