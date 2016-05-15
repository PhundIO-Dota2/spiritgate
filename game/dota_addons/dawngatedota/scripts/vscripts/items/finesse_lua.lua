function OnFinesseAttackLanded(event)
	local caster = event.caster
	local target = event.target

	if target.finesse_table == nil then
		target.finesse_table = {}
	end
	if target.finesse_table[caster] == nil then
		target.finesse_table[caster] = { }
	end
	local finesse_index = 0
	while true do
		finesse_index = finesse_index + 1
		if target.finesse_table[caster][finesse_index] == nil then
			target.finesse_table[caster][finesse_index] = true
			break
		end
	end
	Timers:CreateTimer(3, function()
		target.finesse_table[caster][finesse_index] = nil
	end)
end