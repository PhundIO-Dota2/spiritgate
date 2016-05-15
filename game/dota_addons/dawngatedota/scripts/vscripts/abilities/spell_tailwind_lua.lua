function cast(event)
	local caster = event.caster
	local radius = event.Radius

	local friendlies = GetFriendliesInRadius(caster, radius, false)

	for _, unit in ipairs(friendlies) do
		event.ability:ApplyDataDrivenModifier(caster, unit, "modifier_tailwind", {})
	end
end