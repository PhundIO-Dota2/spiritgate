local camps = { }
local index = 0
while true do
	index = index + 1
	local camp = Entities:FindByName(nil, "camp_" .. index .. "_spawn_1")
	if camp ~= nil then
		camps[index] = { }
		local index2 = 0
		while true do
			index2 = index2 + 1
			local camp_spawn = Entities:FindByName(nil, "camp_" .. index .. "_spawn_" .. index2)
			if camp_spawn ~= nil then
				camps[index][index2] = camp_spawn
			else
				break
			end
		end
		--camps[index].trigger = Entities:FindByName(nil, "trigger_camp_" .. index)
	else
		break
	end
end

local camp_creeps = { }

local camp_types = {
	{"npc_jungle_cute_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_cute_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_ugly_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_ugly_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_scary_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_scary_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_shroom", "npc_jungle_small_shroom", "npc_jungle_small_shroom"},
	{"npc_jungle_big_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_big_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_big_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_big_ugger", "npc_jungle_small_ugger"},
	{"npc_jungle_big_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_big_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_big_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_big_fish", "npc_jungle_small_fish", "npc_jungle_small_fish"},
	{"npc_jungle_big_boar", "npc_jungle_small_boar"},
	{"npc_jungle_big_boar", "npc_jungle_small_boar"},
}

function spawn_creeps(camp, camp_type)
	for k, spawner in ipairs(camp) do
		camp_creeps[camp][k] = CreateUnitByName(camp_type[k], spawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_NEUTRALS)
		local creep = camp_creeps[camp][k]
		creep.is_jungle_creep = true

		Timers:CreateTimer(1 / 30, function()
			if not creep:IsNull() and k == 1 then --First creep in the pack, manages targetting and returning
				local targets = GetEnemyHeroesInRadiusOfPoint(spawner:GetAbsOrigin(), creep:GetTeamNumber(), 650)
				if not creep.jungle_creep_activated then
					for k, v in ipairs(camp_creeps[camp]) do
						if v.jungle_creep_activated then
							creep.jungle_creep_activated = true
						end
					end
				end
				if #targets > 0 and creep.jungle_creep_activated then
					local target = targets[RandomInt(1, #targets)]
					for k2, creep2 in ipairs(camp_creeps[camp]) do
						if not creep2:IsNull() and creep2:IsAlive() then
					      	local order = {}
					      	order.UnitIndex = creep2:GetEntityIndex()
					      	order.OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET
					      	order.TargetIndex = target:GetEntityIndex()
					      	ExecuteOrderFromTable(order)
					    end
					end
				else
					for k2, creep2 in ipairs(camp_creeps[camp]) do
						if not creep2:IsNull() then
					    	local order = {}
					    	order.UnitIndex = creep2:entindex()
					    	order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
					    	order.Position = camp[k2]:GetAbsOrigin()
							order.Queue = false
					    	ExecuteOrderFromTable(order)
					    	if math_distance(creep2:GetAbsOrigin(), camp[k2]:GetAbsOrigin()) > 100 then
					    		creep2:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(creep2, creep2, "modifier_jungle_return_buff", {Duration = 1})
					    	end
					    	creep2.jungle_creep_activated = false
					    end
					end
				end
			end
			return 1 / 15
		end)
	end
end

for k, camp in ipairs(camps) do
	camp_creeps[camp] = { }
	spawn_creeps(camp, camp_types[k])
	Timers:CreateTimer(function()
		local living_creeps = 0
		for k2, creep in ipairs(camp_creeps[camp]) do
			if not creep:IsNull() and creep:IsAlive() then living_creeps = living_creeps + 1 end
		end
		if living_creeps == 0 then
			Timers:CreateTimer(3 * 60, function()
				spawn_creeps(camp, camp_types[k])
			end)
			return 3 * 60 + 1
		end
		return 0.5
	end)
end