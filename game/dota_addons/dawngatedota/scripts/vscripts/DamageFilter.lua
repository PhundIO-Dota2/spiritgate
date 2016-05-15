function GameMode:FilterDamage(filterTable)
	local damage = filterTable.damage
	local damage_type = filterTable.damagetype_const
	local target = EntIndexToHScript(filterTable.entindex_victim_const)
	local caster = nil
	if filterTable.entindex_inflictor_const then
		caster = EntIndexToHScript(filterTable.entindex_inflictor_const)
	end
	local lowest_die_time = nil
	local lowest_shield = nil
	for k, shield_name in pairs(_G.UniversalShields) do
		if target:HasModifier(shield_name) then
			local modifier = target:FindModifierByName(shield_name)
			local die_time = modifier:GetDieTime()
			if lowest_die_time == nil or modifier:GetDieTime() > die_time then
				lowest_die_time = die_time
				lowest_shield = shield_name
			end
		end
	end
	if lowest_shield ~= nil then
		local stacks = target:FindModifierByName(lowest_shield):GetStackCount()
		stacks = stacks - damage
		if stacks <= 0 then
			damage = -stacks
			target:RemoveModifierByName(lowest_shield)
		else
			damage = 0
			target:FindModifierByName(lowest_shield):SetStackCount(stacks)
		end
	end
	if damage == filterTable.damage then
		return true
	else
		if damage > 0 then
			ApplyDamage({victim=target, attacker=caster, damage=damage, damage_type=damage_type})
		end
		return false
	end
end