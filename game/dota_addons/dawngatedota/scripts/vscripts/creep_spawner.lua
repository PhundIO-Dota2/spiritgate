local good_spawner = Entities:FindByName(nil, "npc_dota_scripted_spawner_good")
local bad_spawner = Entities:FindByName(nil, "npc_dota_scripted_spawner_bad")

local reorder_tick_time = 0.5

local creep_level = -1
function tick_creep_level() 
  creep_level = math.min(20, creep_level + 1)
  return 60
end
tick_creep_level()
Timers:CreateTimer(60 * 10, tick_creep_level)

function StartSpawner(spawner, team, path)
  Timers:CreateTimer(function()
    for i=1, 3 do
      local unitMelee = CreateUnitByName("npc_creep_melee", spawner:GetAbsOrigin() + Vector(RandomInt(-100, 100), RandomInt(-100, 100), 0), true, nil, nil, team)
      unitMelee:SetHullRadius(5)
      unitMelee:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(unitMelee, unitMelee, "modifier_spiritgate_creep", {})
      local unitMeleePathPoint = 1

      unitMelee.creep_level_armour = creep_level * 0.5
      unitMelee.creep_level_magic_resistance = creep_level * 0.25
      unitMelee.creep_level_power = creep_level * 0.5
      unitMelee:SetBaseMaxHealth(unitMelee:GetBaseMaxHealth() + 8 * creep_level)
      unitMelee:SetMaxHealth(unitMelee:GetMaxHealth() + 8 * creep_level)
      unitMelee:SetHealth(unitMelee:GetMaxHealth())
      
      Timers:CreateTimer(1 / 30, function()
        if unitMelee:IsNull() then return nil end
        if unitMelee:IsAttacking() then return reorder_tick_time end
        if unitMeleePathPoint < #path and math_distance(unitMelee:GetAbsOrigin(), path[unitMeleePathPoint]) < 200 then
          unitMeleePathPoint = unitMeleePathPoint + 1
        end
        local order = {}
        order.UnitIndex = unitMelee:entindex()
        order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
        order.Position = path[unitMeleePathPoint]
        ExecuteOrderFromTable(order)
        return reorder_tick_time
      end)
      Timers:CreateTimer(1.5, function()
        local unitRanged = CreateUnitByName("npc_creep_ranged", spawner:GetAbsOrigin() + Vector(RandomInt(-100, 100), RandomInt(-100, 100), 0), true, nil, nil, team)

        unitRanged.creep_level_armour = creep_level * 0.28
        unitRanged.creep_level_magic_resistance = creep_level * 0.5
        unitRanged.creep_level_power = creep_level * 1
        unitRanged:SetBaseMaxHealth(unitRanged:GetBaseMaxHealth() + 6 * creep_level)
        unitRanged:SetMaxHealth(unitRanged:GetMaxHealth() + 6 * creep_level)
        unitRanged:SetHealth(unitRanged:GetMaxHealth())

        local unitRangedPathPoint = 1
        unitRanged:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(unitRanged, unitRanged, "modifier_spiritgate_creep", {})

        Timers:CreateTimer(1 / 30, function()
          if unitRanged:IsNull() then return nil end
          if unitRanged:IsAttacking() then return reorder_tick_time end
          if unitRangedPathPoint < #path and math_distance(unitRanged:GetAbsOrigin(), path[unitRangedPathPoint]) < 200 then
            unitRangedPathPoint = unitRangedPathPoint + 1
          end
          local order = {}
          order.UnitIndex = unitRanged:entindex()
          order.OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE
          order.Position = path[unitRangedPathPoint]
          ExecuteOrderFromTable(order)
          return reorder_tick_time
        end)
      end)
    end
    return 30
  end)
end

paths = {
  { Entities:FindByName(nil, "waypoint_botlane_center"):GetAbsOrigin(),
    Entities:FindByName(nil, "guardian_spawner_bad"):GetAbsOrigin(),
  },
  { Entities:FindByName(nil, "waypoint_botlane_center"):GetAbsOrigin(),
    Entities:FindByName(nil, "guardian_spawner_good"):GetAbsOrigin(),
  },
  { Entities:FindByName(nil, "waypoint_toplane_center"):GetAbsOrigin(),
    Entities:FindByName(nil, "guardian_spawner_bad"):GetAbsOrigin(),
  },
  { Entities:FindByName(nil, "waypoint_toplane_center"):GetAbsOrigin(),
    Entities:FindByName(nil, "guardian_spawner_good"):GetAbsOrigin(),
  },
}

Entities:FindByName(nil, "waypoint_botlane_center"):Destroy()
Entities:FindByName(nil, "waypoint_toplane_center"):Destroy()

Timers:CreateTimer(60, function()
  StartSpawner(good_spawner, DOTA_TEAM_GOODGUYS, paths[1])
  StartSpawner(bad_spawner, DOTA_TEAM_BADGUYS, paths[2])
  StartSpawner(good_spawner, DOTA_TEAM_GOODGUYS, paths[3])
  StartSpawner(bad_spawner, DOTA_TEAM_BADGUYS, paths[4])
end)