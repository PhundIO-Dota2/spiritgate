function cast(event)
	local caster = event.caster
	local ability = event.ability
	local target = event.target_points[1]

	local fv = -(caster:GetAbsOrigin() - target):Normalized()
	local spd = 40
	local distance_left = event.Distance

	Timers:CreateTimer(function()
		distance_left = distance_left - spd
		caster:SetForwardVector(fv)
		caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
		if distance_left <= 0 then
			return
		end
		return 1 / 30
	end)
	if not ability.next_cast_is_recast then
		ability.is_awaiting_cast = true
		ability.is_awaiting_cast_timer = Timers:CreateTimer(4, function()
			ability.is_awaiting_cast = false
		end)
	else
		Timers:CreateTimer(function()
			caster:RemoveModifierByName("modifier_mad_king_flourish")
		end)
	end	
	next_cast_is_recast = false
end