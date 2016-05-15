require("json")

function rangepairs(i, to, inc)
	if i == nil then return end -- range(--[[ no args ]]) -> return "nothing" to fail the loop in the caller

	if not to then
	to = i 
	i  = to == 0 and 0 or (to > 0 and 1 or -1) 
	end 

	-- we don't have to do the to == 0 check
	-- 0 -> 0 with any inc would never iterate
	inc = inc or (i < to and 1 or -1) 

	-- step back (once) before we start
	i = i - inc 

	return function () if i == to then return nil end i = i + inc return i, i end 
end 

function math_unit_vector_between_units(u1, u2)
	local u1Pos = u1:GetAbsOrigin()
	local u2Pos = u2:GetAbsOrigin()
	local tx = u1Pos.x - u2Pos.x
	local ty = u1Pos.y - u2Pos.y
	local length = -math.sqrt(math.pow(tx, 2) + math.pow(ty, 2)) --I have no idea how to create a vector with lua, replace this with vector logic
	return Vector(tx / length, ty / length, 0)
end
function math_unit_vector_between_npc_and_pos(npc, pos)
	local u1Pos = npc:GetAbsOrigin()
	local u2Pos = pos
	local tx = u1Pos.x - u2Pos.x
	local ty = u1Pos.y - u2Pos.y
	local length = -math.sqrt(math.pow(tx, 2) + math.pow(ty, 2)) --I have no idea how to create a vector with lua, replace this with vector logic
	return Vector(tx / length, ty / length, 0)
end

function rotate_fv(fv, radians)
	local angle = math.atan2(fv.x, fv.y)
	angle = angle + radians
	return Vector(math.cos(angle), math.sin(angle), 0)
end

function math_distance(n1, n2)
	if n1.GetAbsOrigin ~= nil and n2.GetAbsOrigin then
		return math.sqrt(
			math.pow(
				n1:GetAbsOrigin().x - n2:GetAbsOrigin().x,
				2) + 
			math.pow(
				n1:GetAbsOrigin().y - n2:GetAbsOrigin().y,
				2)
		)
	else
		return math.sqrt(
			math.pow(
				n1.x - n2.x,
				2) + 
			math.pow(
				n1.y - n2.y,
				2)
		)
	end
end
function math.distance(n1, n2)
	return math_distance(n1, n2)
end

function tableContains(list, element)
	if list == nil then return false end
	for i=1, #list do
		if list[i] == element then
			return true
		end
	end
	return false
end
function tableAdd(list, element)
	if list == nil then return false end
	list[#list + 1] = element
	return true
end
function tableRemove(list, element)
	for k, v in ipairs(list) do
		if v == element then table.remove(list, k) return end
	end
end

function GetEnemiesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetEnemyHeroesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_HERO
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetNearestEnemyHeroesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_HERO
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetNearestEnemiesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetUnitsInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY + DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetFriendliesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetFriendliesInRadiusOfPointClosest(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetFriendyHeroesInRadiusOfPoint(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetFriendyHeroesInRadiusOfPointClosest(point, team, radius, DEBUG)
	local iTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(point, Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, point, nil, radius, iTeam, iType, iFlag, iOrder, false)
end

function GetEnemiesInRadius(unit, radius, DEBUG)
	return GetEnemiesInRadiusOfPoint(unit:GetAbsOrigin(), unit:GetTeamNumber(), radius, DEBUG)
end
function GetFriendliesInRadius(unit, radius, DEBUG)
	return GetFriendliesInRadiusOfPoint(unit:GetAbsOrigin(), unit:GetTeamNumber(), radius, DEBUG)
end
function GetEnemiesInRadiusOf(unit, target_unit, radius, DEBUG)
	return GetEnemiesInRadiusOfPoint(target_unit:GetAbsOrigin(), unit:GetTeamNumber(), radius, DEBUG)
end
function GetEnemiesInRadiusOfClosest(unit, target_unit, radius, DEBUG)
	local team = unit:GetTeamNumber()
	local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(target_unit:GetAbsOrigin(), Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, target_unit:GetAbsOrigin(), nil, radius, iTeam, iType, iFlag, iOrder, false)
end
function GetFriendliesInRadiusOfClosest(unit, target_unit, radius, DEBUG)
	local team = unit:GetTeamNumber()
	local iTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_CLOSEST

	if DEBUG then DebugDrawCircle(target_unit:GetAbsOrigin(), Vector(255, 0, 0), 50, radius, true, 2) end
	
	return FindUnitsInRadius(team, target_unit:GetAbsOrigin(), nil, radius, iTeam, iType, iFlag, iOrder, false)
end

function GetEnemiesInCone(unit, radius, fv, stretch, DEBUG)
	return GetUnitsInCone(unit, radius, fv, stretch, DOTA_UNIT_TARGET_TEAM_ENEMY, DEBUG)
end

function GetFriendliesInCone(unit, radius, fv, stretch, DEBUG)
	return GetUnitsInCone(unit, radius, fv, stretch, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DEBUG)
end

function GetUnitsInCone(unit, radius, fv, stretch, iTeam, DEBUG)
	if stretch == nil then stretch = 1 end
	local start_radius = radius / 3 * stretch
	local end_radius = radius / 1.5 * stretch
	local end_distance = radius

	if fv == nil then fv = unit:GetForwardVector() end
	local origin = unit:GetAbsOrigin()
	local start_point = origin + fv * start_radius
	local end_point = origin + fv * (start_radius + end_distance)
	if DEBUG then
		DebugDrawCircle(start_point, Vector(255, 0, 0), 50, start_radius, true, 3)
		DebugDrawCircle(end_point, Vector(255, 0, 0), 50, end_radius, true, 3)
	end
	local mid_interval = end_distance - start_radius - end_radius
	local mid_radius = (start_radius + end_radius) / 2
	local mid_point = origin + fv * mid_radius * 1.5
	
	if DEBUG then
		DebugDrawCircle(mid_point, Vector(0, 255, 0), 50, mid_radius, true, 3)
		DebugDrawCircle(start_point, Vector(255, 0, 255), 50, radius, true, 3)

		DebugDrawCircle(unit:GetAbsOrigin(), Vector(100, 100, 100), 50, radius, true, 3)
	end
	
	local team = unit:GetTeamNumber()
	local iTeam = iTeam
	local iType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
	local iFlag = DOTA_UNIT_TARGET_FLAG_NONE
	local iOrder = FIND_ANY_ORDER
	
	local start_units = FindUnitsInRadius(team, start_point, nil, start_radius, iTeam, iType, iFlag, iOrder, false)
	local end_units = FindUnitsInRadius(team, end_point, nil, end_radius, iTeam, iType, iFlag, iOrder, false)
	local mid_units = FindUnitsInRadius(team, mid_point, nil, mid_radius, iTeam, iType, iFlag, iOrder, false)
	local valid_units = FindUnitsInRadius(team, start_point, nil, radius, iTeam, iType, iFlag, iOrder, false)
	
	local cone_units = {}
	for k,v in pairs(end_units) do 
		if tableContains(valid_units, v) then 
			table.insert(cone_units, v)
		end 
	end
	for k,v in pairs(mid_units) do 
		if tableContains(valid_units, v) then 
			if not tableContains(cone_units, v) then 
				table.insert(cone_units, v) 
			end 
		end 
	end
	for k,v in pairs(start_units) do 
		if tableContains(valid_units, v) then 
			if not tableContains(cone_units, v) then 
				table.insert(cone_units, v) 
			end 
		end 
	end

	local final_radius = FindUnitsInRadius(team, unit:GetAbsOrigin(), nil, radius, iTeam, iType, iFlag, iOrder, false)
	for k,v in pairs(cone_units) do
		if not tableContains(final_radius, v) then
			table.remove(cone_units, k)
		end
	end
	
	return cone_units
end

function knockback_unit(unit, origin, duration, distance, height, should_stun)
	local modifierKnockback = {
		center_x = origin.x,
		center_y = origin.y,
		center_z = origin.z,
		knockback_duration = duration,
		knockback_distance = distance,
		knockback_height = height,
		duration = duration,
	}
	if should_stun then
		modifierKnockback.should_stun = 1
	end
	unit:AddNewModifier(unit, nil, "modifier_knockback", modifierKnockback)
end

function create_dummy(caster)
	local unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, unit, "modifier_dummy_unit", {})
	unit:SetHullRadius(0)
	return unit
end

function get_ability_cooldown(npc, ability)
	local ability_kv = LoadKeyValues("scripts/npc/abilities/" .. ability:GetAbilityName() .. ".txt")

	local pid = npc:GetPlayerID()
  	local haste_rate = haste_cooldown_application_ratios[PlayerResource:GetSelectedHeroName(pid)]
  	local cdDefault = ability:GetCooldown(ability:GetLevel() - 1)
  	
  	local haste = find_stat(npc, "haste")
  	local cdReduced = (100 * cdDefault) / (100 + haste_rate * haste)
  	if npc:HasModifier("item_defiance_cdr") then
		cdReduced = cdReduced / 2
    end
        
    if ability_kv.AbilityCooldownFixed == 1 then
		cdReduced = cdDefault
    end
    if string.starts(ability:GetAbilityName(), "spell_") then
    	multiplier = 1.0
    	if find_item(npc, "item_inspiration") then
    		multiplier = multiplier * 0.9
    	end
    	if find_item(npc, "item_corruption") then
    		multiplier = multiplier * 0.9
    	end
    	if find_item(npc, "item_furor") then
    		multiplier = multiplier * 0.9
    	end
    	if find_item(npc, "item_grace") then
    		multiplier = multiplier * 0.9
    	end
    	if find_item(npc, "item_duress") then
    		multiplier = multiplier * 0.9
    	end
    	cdReduced = cdReduced * multiplier
    end
    return cdReduced
end

function get_cooldown_reduction_percentage(npc)
	local pid = npc:GetPlayerID()
  	local haste_rate = haste_cooldown_application_ratios[PlayerResource:GetSelectedHeroName(pid)]
	local cdDefault = 1
  	local haste = find_stat(npc, "haste")
  	local cdReduced = (100 * cdDefault) / (100 + haste_rate * haste)
  	if npc:HasModifier("item_defiance_cdr") then
		cdReduced = cdReduced / 2
    end
    return cdReduced
end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end