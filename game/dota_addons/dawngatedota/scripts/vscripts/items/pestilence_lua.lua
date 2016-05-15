function OnEquip(event)
	local caster = event.caster
	local item = event.ability
	item.active = true
	Timers:CreateTimer(function()
		if item.active == false then return end
		local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 800, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
		if #units > 1 then
			local unit = units[2] --Exclude self
			if item.current_unit ~= nil and item.current_unit ~= unit and not item.current_unit:IsNull() then
				item.current_unit:RemoveModifierByName("modifier_plague_host_host")
			end
			item.current_unit = unit
			item:ApplyDataDrivenModifier(caster, unit, "modifier_plague_host_host", {})
			unit.plague_host = caster
		elseif item.current_unit ~= nil and not item.current_unit:IsNull() then
			item.current_unit:RemoveModifierByName("modifier_plague_host_host")
		end
		return 0.25
	end)
end

function OnUnequip(event)
	local item = event.ability
	item.active = false
	if item.current_unit ~= nil and not item.current_unit:IsNull() then
		item.current_unit:RemoveModifierByName("modifier_plague_host_host")
	end
	item.current_unit = nil
end