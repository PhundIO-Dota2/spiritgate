function cast(event)
	local caster = event.caster

	if caster:GetHealth() <= event.HealthCost + 1 then 
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return 
	end

	caster:SetHealth(caster:GetHealth() - event.HealthCost)
end