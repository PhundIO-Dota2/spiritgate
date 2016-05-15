function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, caster, "whale_hunter_surge_movement_speed", {})
	ability:ApplyDataDrivenModifier(caster, caster, "whale_hunter_surge_visible_bonus_attack_damage", {})
	ability:ApplyDataDrivenModifier(caster, caster, "whale_hunter_surge_bonus_attack_damage", {})
	caster:SetModifierStackCount("whale_hunter_surge_bonus_attack_damage", caster, event.Damage + event.DamagePowerRatio * find_stat(caster, "power"))

	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local spd = 35
	local distance_left = event.Distance

	caster:Stop()

	Timers.CreateTimer(0, function()
		distance_left = distance_left - spd
		caster:SetForwardVector(fv)
		caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
		caster:SetAbsOrigin(GetGroundPosition(caster:GetAbsOrigin(), caster))
		local old_pos = caster:GetAbsOrigin()
		FindClearSpaceForUnit(caster, old_pos, false)
		if caster:GetAbsOrigin() ~= old_pos then
			return
		end

		if distance_left <= 0 then
			return
		end

		return 0.03
	end)
end

function on_attack_landed(event)
	local caster = event.caster
	local ability = event.ability

	caster:RemoveModifierByName("whale_hunter_surge_bonus_attack_damage")
	caster:RemoveModifierByName("whale_hunter_surge_visible_bonus_attack_damage")

	if not ability.is_recast then
		ability:EndCooldown()
	end
	ability.is_recast = not ability.is_recast
	if not ability.is_recast then
		Timers:RemoveTimer(ability.recast_timer)
		return
	end
	ability.recast_timer = Timers:CreateTimer(4, function()
		ability.is_recast = false
		ability:StartCooldown(get_ability_cooldown(caster, ability))
	end)
end