function cast(event)
	local caster = event.caster
	local ability = event.ability

	if caster:IsRangedAttacker() then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_blitz", {Duration = event.RangedShaperDuration})
	else
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_blitz", {Duration = event.MeleeShaperDuration})
	end
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_blitz_movement_speed", {})
end