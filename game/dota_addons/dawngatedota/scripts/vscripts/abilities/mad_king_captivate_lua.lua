function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local pid = ParticleManager:CreateParticle("particles/kom_captivate/captivate_projectile_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	
	local pos = caster:GetAbsOrigin()
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local spd = 27
	local distance_travelled = 0

	local potential_witnesses = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 1200)
	for k, potential_witness in pairs(potential_witnesses) do
		if caster:HasModifier("modifier_mad_king_flourish") and potential_witness:IsHero() and caster:CanEntityBeSeenByMyTeam(potential_witness) then
			local flourish = caster:FindAbilityByName("ability_mad_king_flourish")
			if flourish.is_awaiting_cast then
				Timers:RemoveTimer(flourish.is_awaiting_cast_timer)
				flourish.is_awaiting_cast = false
				flourish.next_cast_is_recast = true
				Timers:CreateTimer(3, function()
					flourish:StartCooldown(get_ability_cooldown(caster, flourish))
					flourish.next_cast_is_recast = false
				end)
				flourish:EndCooldown()
			end
		end
	end

	Timers:CreateTimer(function()
		distance_travelled = distance_travelled + spd
		pos = pos + fv * spd
		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
		local enemies = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 60)
		if #enemies > 0 then
			disable({
				caster = event.caster,
				target = enemies[1],
				Duration = 3,
				DisableModifier = "modifier_captivate_slow",
				ability = event.ability
			})
			if caster:HasModifier("modifier_mad_king_flourish")	then
				disable({
					caster = event.caster,
					target = enemies[1],
					Duration = event.FlourishRootDuration,
					DisableModifier = "modifier_captivate_rooted",
					ability = event.ability
				})
				caster:RemoveModifierByName("modifier_mad_king_flourish")
			end
			ParticleManager:DestroyParticle(pid, false)
			create_tentacles(event, enemies[1]:GetAbsOrigin())
			return
		end
		if distance_travelled > event.CastRange then
			ParticleManager:DestroyParticle(pid, false)
			create_tentacles(event, pos)
			return
		end
		return 1 / 30
	end)
end

function create_tentacles(event, pos)
	dofile("deal_damage")

	local caster = event.caster
	local pos_offsets = {
		Vector(-45, -25, 10) * 1.2,
		Vector(45, -25, 10) * 1.2,
		Vector(0, 35, 10) * 1.2
	}
	for i=1,3 do
		local pid = ParticleManager:CreateParticle("particles/kom_captivate/captivate_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
		local new_pos = pos + pos_offsets[i] + RandomVector(10)
		local enemy = GetNearestEnemiesInRadiusOfPoint(new_pos, caster:GetTeamNumber(), 200)[1]
		ParticleManager:SetParticleControl(pid, 0, new_pos)
		if enemy ~= nil then
			ParticleManager:SetParticleControl(pid, 1, enemy:GetAbsOrigin() + Vector(0, 0, 75) - (enemy:GetAbsOrigin() - new_pos):Normalized() * 50)
			Timers:CreateTimer(0.65, function()
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, false)
			end)
		end
	end
end