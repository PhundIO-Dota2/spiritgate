function cast(event)
	local caster = event.caster
	local ability = event.ability
	local target = nil
	if caster:GetAttackTarget() ~= nil then
		if not caster:GetAttackTarget():HasModifier("modifier_whale_hunter_knife_stuck") then
			target = caster:GetAttackTarget()
		end
	else
		for k, v in pairs(GetNearestEnemyHeroesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)) do
			if not v:HasModifier("modifier_whale_hunter_knife_stuck")  then
				target = v
				break
			end
		end
		if target == nil then
			for k, v in pairs(GetNearestEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)) do
				if not v:HasModifier("modifier_whale_hunter_knife_stuck") then
					target = v
					break
				end
			end
		end
	end

	if target == nil or caster:GetModifierStackCount("modifier_whale_hunter_knives", caster) < 1 then
		ability:EndCooldown()
	else
		caster:SetModifierStackCount("modifier_rage_adrenaline_stack", caster,	math.min(100, caster:GetModifierStackCount("modifier_rage_adrenaline_stack", caster) + 10))
		caster:SetModifierStackCount("modifier_whale_hunter_knives", caster, caster:GetModifierStackCount("modifier_whale_hunter_knives", caster) - 1)
		dofile("deal_damage")
		local pid = ParticleManager:CreateParticle("particles/whale_hunter/knife_toss.vpcf", PATTACH_CUSTOMORIGIN, nil)
		local pid_pos = caster:GetAbsOrigin()
		local spd = 37
		Timers:CreateTimer(function()
			if math.distance(pid_pos, target:GetAbsOrigin()) < spd * 3 then
				ParticleManager:DestroyParticle(pid, true)
				target.knife_stuck = caster
				if target.knife_stuck_damage == nil then target.knife_stuck_damage = 0 end
				target.knife_stuck_damage = target.knife_stuck_damage + event.IncreasedDamageTaken
				ability:ApplyDataDrivenModifier(caster, target, "modifier_whale_hunter_knife_stuck", {})
				Timers:CreateTimer(5, function()
					target:RemoveModifierByName("modifier_whale_hunter_knife_stuck")
					target.knife_stuck = nil
					target.knife_stuck_damage = target.knife_stuck_damage - event.IncreasedDamageTaken
				end)
				deal_damage(caster, target, event.Damage, event.DamagePowerRatio, DAMAGE_TYPE_PHYSICAL, ability, false, false, false)
				return
			end
			pid_pos = pid_pos - (pid_pos - target:GetAbsOrigin()):Normalized() * spd
			ParticleManager:SetParticleControl(pid, 0, pid_pos + Vector(0, 0, 100))
			ParticleManager:SetParticleControl(pid, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
			return 1 / 30
		end)
	end
end

function AddKnife(event)
	local caster = event.caster
	local ability = event.ability

	caster:SetModifierStackCount("modifier_whale_hunter_knives", caster, math.min(2, (caster:GetModifierStackCount("modifier_whale_hunter_knives", caster) + 1)))
end