function cast(event)
	local caster = event.caster
	local target_point = event.target_points[1]

	if event.ability.recastable == nil or event.ability.recastable == false then
		local fv = (target_point - caster:GetAbsOrigin()):Normalized()

		local pid = ParticleManager:CreateParticle("particles/kel_sheep_toss/sheep_toss_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		event.ability.pid = pid
		local pid_pos = caster:GetAbsOrigin()
		ParticleManager:SetParticleControl(pid, 0, pid_pos + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid, 1, pid_pos + fv * event.Range + Vector(0, 0, 25))
		ParticleManager:SetParticleControlForward(pid, 1, fv)
		times = 0

		local all_hits = {}
		dofile("deal_damage")
		event.ability.recastable = true
		event.ability.sheep_pos = GetGroundPosition(pid_pos + fv * event.Range, caster)
		event.ability.recast_timer = Timers:CreateTimer(4, function()
			ParticleManager:DestroyParticle(event.ability.pid, true)
			end_recast(event)
		end)

		Timers:CreateTimer(function()
			pid_pos = pid_pos + fv * event.Range / 7
			times = times + 1
			local hits = GetEnemiesInRadiusOfPoint(pid_pos, caster:GetTeamNumber(), 100)
			for k,v in pairs(hits) do
				if not tableContains(all_hits, v) then
					all_hits[#all_hits + 1] = v
					deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
				end
			end
			if times > 6 then
				return
			end
			return 0.1
		end)

		event.ability:EndCooldown()
	else
		end_recast(event)
		local all_hits = {}
		dofile("deal_damage")
		Timers:CreateTimer(function()
			local fv = (event.ability.sheep_pos - caster:GetAbsOrigin()):Normalized()
			if (event.ability.sheep_pos - caster:GetAbsOrigin()):Length2D() < 60 then
				ParticleManager:DestroyParticle(event.ability.pid, true)
				caster:SetAbsOrigin(event.ability.sheep_pos)
				FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
				return
			end
			local hits = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), 100)
			for k,v in pairs(hits) do
				if not tableContains(all_hits, v) then
					all_hits[#all_hits + 1] = v
					deal_damage(caster, v, event.DashDamage, event.DashDamagePowerRatio, 1, event.ability, false, false, true)
				end
			end
			caster:SetForwardVector(fv)
			caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * 60)
			return 1 / 30
		end)
	end
end

function end_recast(event)
	event.ability.recastable = false
	Timers:RemoveTimer(event.ability.recast_timer)
end