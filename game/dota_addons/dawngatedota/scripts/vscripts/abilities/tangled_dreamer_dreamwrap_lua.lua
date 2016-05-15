function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if ability.casts == nil then
		ability.casts = 0
	end
	ability.casts = ability.casts + 1
	if ability.casts ~= 3 then
		ability:EndCooldown()
	else
		Timers:RemoveTimer(ability.recast_end_timer)
		ability.casts = 0
	end
	if ability.casts == 1 then
		ability.recast_end_timer = Timers:CreateTimer(4, function()
			ability:StartCooldown(get_ability_cooldown(caster, ability))
			ability.casts = 0
		end)
	end

	ability:ApplyDataDrivenModifier(caster, target, "modifier_dreamwrap_speed", {})
	ability:ApplyDataDrivenModifier(caster, target, "modifier_dreamwrap", {})
	target:SetModifierStackCount("modifier_dreamwrap", caster, target:GetModifierStackCount("modifier_dreamwrap", caster) + event.Shield + find_stat(caster, "power") * event.ShieldPowerRatio)
end