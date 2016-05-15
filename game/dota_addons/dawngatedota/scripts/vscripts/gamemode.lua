JSON = assert(loadfile "json")()
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')

require('DamageFilter')

local selected_shapers = {}
local selected_roles = {}
local selected_skins = {}

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.
  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.
  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).
  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

local HeroSelectTimeLeft = 60
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
  Convars:RegisterCommand( "dofile", function( cmd, filename )
      dofile(filename)
    end, "Dofile lua", FCVAR_CHEAT
  )
  dofile("mapscripts/guardian")
  dofile("mapscripts/jungle")
  dofile("mapscripts/binding")
  dofile("mapscripts/parasite")
  local spiritwell = require("mapscripts/spiritwell")
  spiritwell.init()

  Timers:CreateTimer(function()
    if HeroSelectTimeLeft >= 0 then
      CustomGameEventManager:Send_ServerToAllClients( "picking_time_update", {time = HeroSelectTimeLeft} )
    end
    if HeroSelectTimeLeft > 2 then
      do_skip = true
      for i=0, 9 do
        if PlayerResource:IsValidPlayerID(i) then
          if locked_pids[i] == nil or locked_pids[i] == false then
            do_skip = false
          end
        end
      end
      if do_skip then
        HeroSelectTimeLeft = 2
      end
    end
    HeroSelectTimeLeft = HeroSelectTimeLeft - 1
    if HeroSelectTimeLeft >= 0 then
      return 1
    end
    for i=0, 9 do
      if PlayerResource:IsValidPlayerID(i) then
        local player = PlayerResource:GetPlayer(i)
        local selected_skin = selected_skins[i]
        if selected_shapers[i] == "npc_dota_hero_bane" then
          selected_shapers[i] = "npc_dota_hero_rattletrap"
        end
        if selected_roles[i] == nil then
          selected_roles[i] = "Tactician"
        end
        PrecacheUnitByNameAsync(selected_shapers[i], function()
          PlayerResource:ReplaceHeroWith(i, selected_shapers[i], 500, 0)
          Timers:CreateTimer(function()
            local hero = player:GetAssignedHero()
            hero:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(hero, hero, "modifier_role_" .. string.lower(selected_roles[i]), {})
            CreateHTTPRequest("GET", "http://spiritgate.net/api/get_loadout_stats/" .. player_id_to_64[i + 1] .. "/1"):Send(function (response)
              local loadout_stats = JSON:decode(response.Body)
              hero.loadout_stats = loadout_stats
            end)
            if selected_skin ~= "default" then
              hero:SetOriginalModel("models/heroes/desecrator/desecrator_ramen_tomb.vmdl")
            end
          end, i)
          CustomGameEventManager:Send_ServerToPlayer(player, "picking_time_over", {})
        end)
      end
    end
    return nil
  end)

  local fow_revealers = Entities:FindAllByName("bush_fow_revealer")
  for k, revealer in ipairs(fow_revealers) do
    revealer:SetModel("models/development/invisiblebox.vmdl")
  end
end

selected_shapers = {}
selected_roles = {}
locked_pids = {}

function GameMode:SelectShaper(source, event)
  selected_shapers[source.PlayerID] = source.shaper

  CustomGameEventManager:Send_ServerToAllClients( "SelectShaper", {pid = source.PlayerID, shaper = source.shaper } )
end
function GameMode:SelectRole(source, event)
  selected_roles[source.PlayerID] = source.role

  CustomGameEventManager:Send_ServerToAllClients( "SelectRole", {pid = source.PlayerID, role = source.role } )
end
function GameMode:SelectSkin(source, event)
  selected_skins[source.PlayerID] = source.skin
end
function GameMode:LockSelections(source, event)
  local pid = source.PlayerID
  locked_pids[pid] = true
end

function GameMode:ReconnectCloseSelection(source, event)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  if HeroSelectTimeLeft <= 0 then
    CustomGameEventManager:Send_ServerToPlayer(player, "picking_time_over", {})
  end
end

function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  hero:SetGold(500, false)
  selected_shapers[hero:GetPlayerOwnerID()] = hero:GetUnitName()
end


GAME_START_TICKER = nil
GAME_START_TICKER_LEFT = 30
GAME_STARTED = false

function GameMode:OnGameInProgress()
  GAME_STARTED = true
  dofile("creep_spawner")
  return nil
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

  -- Call the internal function to set up the rules/behaviors specified in constants.lua
  -- This also sets up event hooks for all event handlers in events.lua
  -- Check out internals/gamemode to see/modify the exact code
  GameMode:_InitGameMode()

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  --Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')

  CustomGameEventManager:RegisterListener("BuyItem", Dynamic_Wrap(GameMode, "BuyItem"))
  CustomGameEventManager:RegisterListener("SellItem", Dynamic_Wrap(GameMode, "SellItem"))
  CustomGameEventManager:RegisterListener("LevelAbility", Dynamic_Wrap(GameMode, "LevelAbility"))

  CustomGameEventManager:RegisterListener("SelectShaper", Dynamic_Wrap(GameMode, "SelectShaper"))
  CustomGameEventManager:RegisterListener("SelectRole", Dynamic_Wrap(GameMode, "SelectRole"))
  CustomGameEventManager:RegisterListener("SelectSkin", Dynamic_Wrap(GameMode, "SelectSkin"))
  CustomGameEventManager:RegisterListener("LockSelections", Dynamic_Wrap(GameMode, "LockSelections"))
  
  CustomGameEventManager:RegisterListener("SpiritgateChat", Dynamic_Wrap(GameMode, "SpiritgateChat"))

  CustomGameEventManager:RegisterListener("player_reconnected", Dynamic_Wrap(GameMode, "ReconnectCloseSelection"))

  CustomGameEventManager:RegisterListener("GetSpiritgateAbilityTargetInfo", Dynamic_Wrap(GameMode, "GetSpiritgateAbilityTargetInfo"))

  CustomGameEventManager:RegisterListener("SelectSpell", Dynamic_Wrap(GameMode, "OnSelectSpell"))

  CustomGameEventManager:RegisterListener("MinimapMove", Dynamic_Wrap(GameMode, "OnMinimapMove"))
  CustomGameEventManager:RegisterListener("MinimapMovePlayer", Dynamic_Wrap(GameMode, "OnMinimapMovePlayer"))

  GameRules:GetGameModeEntity():SetExecuteOrderFilter(Dynamic_Wrap(GameMode, "FilterExecuteOrder"), self )
  GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode, "FilterDamage"), self)
end

function GameMode:OnMinimapMove(source, event)
  local pid = source.PlayerID
  local entity = PlayerResource:GetSelectedHeroEntity(pid)
  local xpos = source.x
  local ypos = source.y

  local map_size = 15800
  local new_pos = GetGroundPosition(Vector(xpos * map_size - map_size / 2, -ypos * map_size + map_size / 2, 0), entity)

  local dummy_unit = CreateUnitByName("npc_typhoon_riptide", new_pos, false, nil, nil, entity:GetTeamNumber())
  dummy_unit:AddNewModifier(dummy_unit, nil, "modifier_invulnerable", {})
  CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "MinimapCameraDummyUnitPositionUpdate", {id = dummy_unit:GetEntityIndex()})
  Timers:CreateTimer(0.33, function() 
    dummy_unit:ForceKill(false)
  end)
end

function GameMode:OnMinimapMovePlayer(source, event)
  local pid = source.PlayerID
  local entity = PlayerResource:GetSelectedHeroEntity(pid)
  local xpos = source.x
  local ypos = source.y

  local map_size = 15800
  local new_pos = GetGroundPosition(Vector(xpos * map_size - map_size / 2, -ypos * map_size + map_size / 2, 0), entity)

  local order = {}
  order.UnitIndex = entity:entindex()
  order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
  order.Position = new_pos
  ExecuteOrderFromTable(order)
end

function GameMode:OnSelectSpell(source, event)
  local pid = source.PlayerID
  local spell = source.spell

  local hero = PlayerResource:GetSelectedHeroEntity(pid)

  hero:AddAbility("spell_" .. spell)
  hero:FindAbilityByName("spell_" .. spell):SetLevel(1)
  hero.spell_points = hero.spell_points - 1
end

function GameMode:GetSpiritgateAbilityTargetInfo(source, event)
 local pid = source.PlayerID

 CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(pid), "GetSpiritgateAbilityTargetInfo", {data = LoadKeyValues("scripts/npc/npc_abilities_custom.txt")})
end

function GameMode:SpiritgateChat(source, event)
  local pid = source.PlayerID
  local text = source.text
  CustomGameEventManager:Send_ServerToTeam(PlayerResource:GetTeam(pid), "SpiritgateChat", {pid = pid, text = text})  
end

function GameMode:FilterExecuteOrder( filterTable )
    local units = filterTable["units"]
    local order_type = filterTable["order_type"]
    local issuer = filterTable["issuer_player_id_const"]
    local abilityIndex = filterTable["entindex_ability"]
    local targetIndex = filterTable["entindex_target"]
    local x = tonumber(filterTable["position_x"])
    local y = tonumber(filterTable["position_y"])
    local z = tonumber(filterTable["position_z"])
    local point = Vector(x,y,z)

    local ability = EntIndexToHScript(abilityIndex)

    if order_type == DOTA_UNIT_ORDER_GLYPH then
      return false
    end

    if units["0"] == nil or not EntIndexToHScript(units["0"]):IsHero() then
      return true
    end

    local unit = EntIndexToHScript(units["0"])

    if unit.current_channeled_ability ~= nil and unit.current_channeled_ability.CancelOnAction then
      local channeled_ability = require("abilities/ability_channeled_lua")
      channeled_ability.Interrupt(unit.current_channeled_ability)
    end

    if order_type == DOTA_UNIT_ORDER_CAST_POSITION or order_type == DOTA_UNIT_ORDER_CAST_TARGET or order_type == DOTA_UNIT_ORDER_CAST_TARGET_TREE or
       order_type == DOTA_UNIT_ORDER_MOVE_TO_POSITION or order_type == DOTA_UNIT_ORDER_MOVE_TO_TARGET or order_type == DOTA_UNIT_ORDER_ATTACK_MOVE or
       order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
      --unit:SetForwardVector(-(unit:GetOrigin() - point))
    end

    --[[

    if unit.preattack_timer ~= nil then
      if order_type == 1 or order_type == 2 or ability == nil or (ability.GetAbilityName ~= nil and ability:GetAbilityName() ~= "ability_universal_attack") then
        Timers:RemoveTimer(unit.preattack_timer)
        unit.preattack_timer = nil
        EndAnimation(unit)
      end
    end

    if order_type == DOTA_UNIT_ORDER_ATTACK_TARGET then
      local universal_attack_ability = unit:FindAbilityByName("ability_universal_attack")
      unit:CastAbilityOnTarget(EntIndexToHScript(targetIndex), universal_attack_ability, issuer)
      if unit.universal_attack_recaster ~= nil then
        Timers:RemoveTimer(unit.universal_attack_recaster)
      end
      unit.universal_attack_recaster = Timers:CreateTimer(function()
        unit:CastAbilityOnTarget(EntIndexToHScript(targetIndex), universal_attack_ability, issuer)
        return 1 / 30
      end)
      return false
    elseif order_type == DOTA_UNIT_ORDER_ATTACK_MOVE then
      local universal_attack_ability = unit:FindAbilityByName("ability_universal_attack")
      local new_order = {}
      new_order.UnitIndex = unit:entindex()
      new_order.OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION
      new_order.Position = Vector(x, y, z)
      ExecuteOrderFromTable(new_order)
      if unit.universal_attack_recaster ~= nil then
        Timers:RemoveTimer(unit.universal_attack_recaster)
        unit.attack_move_target = nil
      end
      unit.universal_attack_recaster = Timers:CreateTimer(function()
        local targets = GetEnemiesInRadiusOfPoint(unit:GetAbsOrigin(), unit:GetTeamNumber(), unit:GetAcquisitionRange())
        
        if unit.attack_move_target ~= nil and tableContains(targets, unit.attack_move_target) then
            unit:CastAbilityOnTarget(unit.attack_move_target, universal_attack_ability, issuer)
        else
          local longest_range = 1000000
          for _, current_target in pairs(targets) do
            if math_distance(unit, current_target) < longest_range then
              longest_range = math_distance(unit, current_target)
              unit.attack_move_target = current_target
              unit:CastAbilityOnTarget(current_target, universal_attack_ability, issuer)
            end
            break
          end
        end
        return 1 / 30
      end)
      return false
    end
    if unit.universal_attack_recaster ~= nil then
      Timers:RemoveTimer(unit.universal_attack_recaster)
      unit.attack_move_target = nil
    end
    --]]
    return true
end
ORDERS = {
    [0] = "DOTA_UNIT_ORDER_NONE",
    [1] = "DOTA_UNIT_ORDER_MOVE_TO_POSITION",
    [2] = "DOTA_UNIT_ORDER_MOVE_TO_TARGET",
    [3] = "DOTA_UNIT_ORDER_ATTACK_MOVE",
    [4] = "DOTA_UNIT_ORDER_ATTACK_TARGET",
    [5] = "DOTA_UNIT_ORDER_CAST_POSITION",
    [6] = "DOTA_UNIT_ORDER_CAST_TARGET",
    [7] = "DOTA_UNIT_ORDER_CAST_TARGET_TREE",
    [8] = "DOTA_UNIT_ORDER_CAST_NO_TARGET",
    [9] = "DOTA_UNIT_ORDER_CAST_TOGGLE",
    [10] = "DOTA_UNIT_ORDER_HOLD_POSITION",
    [11] = "DOTA_UNIT_ORDER_TRAIN_ABILITY",
    [12] = "DOTA_UNIT_ORDER_DROP_ITEM",
    [13] = "DOTA_UNIT_ORDER_GIVE_ITEM",
    [14] = "DOTA_UNIT_ORDER_PICKUP_ITEM",
    [15] = "DOTA_UNIT_ORDER_PICKUP_RUNE",
    [16] = "DOTA_UNIT_ORDER_PURCHASE_ITEM",
    [17] = "DOTA_UNIT_ORDER_SELL_ITEM",
    [18] = "DOTA_UNIT_ORDER_DISASSEMBLE_ITEM",
    [19] = "DOTA_UNIT_ORDER_MOVE_ITEM",
    [20] = "DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO",
    [21] = "DOTA_UNIT_ORDER_STOP",
    [22] = "DOTA_UNIT_ORDER_TAUNT",
    [23] = "DOTA_UNIT_ORDER_BUYBACK",
    [24] = "DOTA_UNIT_ORDER_GLYPH",
    [25] = "DOTA_UNIT_ORDER_EJECT_ITEM_FROM_STASH",
    [26] = "DOTA_UNIT_ORDER_CAST_RUNE",
    [27] = "DOTA_UNIT_ORDER_PING_ABILITY",
    [28] = "DOTA_UNIT_ORDER_MOVE_TO_DIRECTION",
}

function GameMode:LevelAbility(source, event)
  local player = PlayerResource:GetPlayer(source.PlayerID)
  local caster = player:GetAssignedHero()

  local index = source.index

  if caster:GetAbilityPoints() > 0 then
    caster:SetAbilityPoints(caster:GetAbilityPoints() - 1)
    caster:GetAbilityByIndex(index):SetLevel(caster:GetAbilityByIndex(index):GetLevel() + 1)
  end
end

function GameMode:BuyItem(source, event)
  local item_name = source.item
  local player = PlayerResource:GetPlayer(source.PlayerID)
  local caster = player:GetAssignedHero()

  local slots_filled = 0
  for i=0, 5 do
    local found_item = caster:GetItemInSlot(i)
    if found_item ~= nil then
      slots_filled = slots_filled + 1
    end
  end

  if caster.in_store_range or not caster:IsAlive() then
    local item = CreateItem("item_" .. string.lower(item_name), caster, caster)
    local total_cost = item:GetCost()

    local found_t1_item = -1
    local found_t2_item = -1

    for i=0, 5 do
      local found_item = caster:GetItemInSlot(i)
      if found_item ~= nil then
        if found_item:GetName() == "item_" .. string.lower(source.t1_item) then
          found_t1_item = i
        end
        if found_item:GetName() == "item_" .. string.lower(source.t2_item) then
          found_t2_item = i
        end
      end
    end
    local old_item = nil
    if found_t2_item >= 0 then
      old_item = caster:GetItemInSlot(found_t2_item)
      total_cost = total_cost - old_item:GetCost()
    elseif found_t1_item >= 0 then
      old_item = caster:GetItemInSlot(found_t1_item)
      total_cost = total_cost - old_item:GetCost()
    end
    if (slots_filled < 6 or found_t2_item >= 0 or found_t1_item >= 0) and (caster:GetGold() > total_cost) then
      if old_item ~= nil then
        caster:RemoveItem(old_item)
      end
      caster:AddItem(item)
      caster:SpendGold(total_cost, 0)
    end
  end
end

function GameMode:SellItem(source, event)
  local item_index = source.item_index
  local player = PlayerResource:GetPlayer(source.PlayerID)
  local caster = player:GetAssignedHero()

  if caster.in_store_range or not caster:IsAlive() then
    caster:ModifyGold(caster:GetItemInSlot(item_index):GetCost() / 2, true, 0)
    caster:RemoveItem(caster:GetItemInSlot(item_index))
  end

--[[
  for i=1, 5 do
    if caster:GetItemInSlot(i - 1) == nil and caster:GetItemInSlot(i) ~= nil then
      local item_moved = caster:GetItemInSlot(i)
      caster:RemoveItem(item_moved)
      caster:AddItem(item_moved)
    end
  end
]]
end

player_id_to_64 = {}

ListenToGameEvent('player_connect', function(keys)
  player_id_to_64[keys.userid] = tostring(keys.xuid)
end, nil)