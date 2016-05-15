function cast(event)
	local caster = event.caster
	local ability = event.ability
	local old_count = #caster:FindAllModifiers()
	caster:Purge(false, true, false, true, false)	

	if old_count ~= #caster:FindAllModifiers() then
		ability:ApplyDataDrivenModifier(caster, caster, "modifier_dispel_movement_speed", {})
	end
end