function start_touch(trigger)
	trigger.activator.in_store_range = true
	CustomGameEventManager:Send_ServerToPlayer(trigger.activator:GetPlayerOwner(), "UpdateStore", { active = true })
end
function end_touch(trigger)
	trigger.activator.in_store_range = false
	CustomGameEventManager:Send_ServerToPlayer(trigger.activator:GetPlayerOwner(), "UpdateStore", { active = false })
end