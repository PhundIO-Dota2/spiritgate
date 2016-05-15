function OnCreated(event)
	local caster = event.caster
	local target = event.target
	if target.influence_ticker == nil then
		target.influence_ticker = Timers:CreateTimer(function()
			local found_influence = false
			local friendlies = GetFriendliesInCone(target, 1200, target:GetForwardVector(), 1.3)
			for k, friendly in ipairs(friendlies) do
				if find_item(friendly, "item_influence") then
					found_influence = true
					find_item(friendly, "item_influence"):ApplyDataDrivenModifier(caster, target, "item_influence_movespeed_modifier", { Duration = 1.1 })
				end
			end	
			if not found_influence then
				target:RemoveModifierByName("item_influence_movespeed_modifier")
			end
			return 1 / 10
		end)
	end
end

function OnDestroy(event)
	local caster = event.caster
	local target = event.target
	Timers:RemoveTimer(target.influence_ticker)
	target.influence_ticker = nil
end