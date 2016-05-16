require("stat_application_ratios")
require("KeyValueExtension")
-- This file contains all barebones-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the GameMode:_Function calls in these events as it will mess with the internal barebones systems.

-- Cleanup a player when they leave
function GameMode:OnDisconnect(keys)
  DebugPrint('[BAREBONES] Player Disconnected ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid

end
-- The overall game state has changed
function GameMode:OnGameRulesStateChange(keys)
  DebugPrint("[BAREBONES] GameRules State Changed")
  DebugPrintTable(keys)

  -- This internal handling is used to set up main barebones functions
  GameMode:_OnGameRulesStateChange(keys)

  local newState = GameRules:State_Get()
end

-- An NPC has spawned somewhere in game.  This includes heroes
function GameMode:OnNPCSpawned(keys)
	DebugPrint("[BAREBONES] NPC Spawned")
	DebugPrintTable(keys)

	local npc = EntIndexToHScript(keys.entindex)

  --npc:AddNewModifier(npc, nil, "modifier_bloodseeker_thirst_speed", {})
  npc:AddNewModifier(npc, nil, "modifier_bloodseeker_thirst", {})

  npc:SetMinimumGoldBounty(0)
  npc:SetMaximumGoldBounty(0)

	if not npc:FindAbilityByName("ability_universal_ability") then
		npc:AddAbility("ability_universal_ability")
	end
  npc:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(npc, npc, "modifier_universal", {})

  if npc:GetUnitName() == "npc_jungle_cute_shroom" then
    ParticleManager:CreateParticle("particles/jungle_buffs/haste_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, npc)
  end
  if npc:GetUnitName() == "npc_jungle_ugly_ugger" then
    ParticleManager:CreateParticle("particles/jungle_buffs/armor_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, npc)
  end
  if npc:GetUnitName() == "npc_jungle_scary_fish" then
    ParticleManager:CreateParticle("particles/jungle_buffs/power_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, npc)
  end

	if npc:IsHero() and npc.bFirstSpawned == nil then
    if npc:GetUnitName() == "npc_dota_hero_rattletrap" then
      ParticleManager:CreateParticle("particles/faris_glows/faris_blade_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, npc)
    end
    if npc:GetUnitName() == "npc_dota_hero_bane" then
      npc:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(npc, npc, "modifier_pregame_unit", {});
    else
      npc.spell_points = 1
      CustomGameEventManager:Send_ServerToPlayer(npc:GetPlayerOwner(), "add_spell_point", {})
      npc:FindAbilityByName("ability_universal_attack"):SetLevel(1)
      npc:FindAbilityByName("ability_universal_ability_ward"):SetLevel(1)
      npc:FindAbilityByName("ability_universal_recall"):SetLevel(1)
      npc:FindAbilityByName("consumable_vitality_potion"):SetLevel(1)
    end
    if npc:GetUnitName() == "npc_dota_hero_spectre" or 
       npc:GetUnitName() == "npc_dota_hero_undying" or
       npc:GetUnitName() == "npc_dota_hero_ember_spirit" or
       npc:GetUnitName() == "npc_dota_hero_rattletrap" then
      CosmeticLib:RemoveAll(npc)
    elseif npc:GetUnitName() == "npc_dota_hero_beastmaster" then
      CosmeticLib:RemoveFromSlot(npc, "weapon")
      CosmeticLib:RemoveFromSlot(npc, "head")
      local offset = Vector( 35, 0, 10 )
      local direction = Vector( 0, 0, 1 )
      local scale = 0.8
      local animation = 'bindPose'
      local wep1 = AttachManager:AttachModel(npc, 'models/items/faceless_void/battlefury/battlefury.vmdl', 'attach_attack1', offset, direction, scale, animation)
      
      direction = Vector( 0, 0.5, -1 )
      offset = offset + Vector(-10, -10, -10)
      local wep2 = AttachManager:AttachModel(npc, 'models/items/faceless_void/battlefury/battlefury.vmdl', 'attach_attack2', offset, direction, scale, animation)
    elseif npc:GetUnitName() == "npc_dota_hero_meepo" then
      CosmeticLib:RemoveFromSlot(npc, "weapon")
    elseif npc:GetUnitName() == "npc_dota_hero_vengefulspirit" then
      CosmeticLib:RemoveFromSlot(npc, "weapon")
      --[[ --models/items/vengefulspirit/huangs_umbra_weapon/huangs_umbra_weapon.vmdl ?
      local offset = Vector(-15, -25, -40 )
      local direction = Vector( 0, 0, 1 )
      local scale = 0.7
      local animation = 'bindPose'
      local wep = AttachManager:AttachModel(npc, 'models/items/silencer/fanpiercingsilence/fanpiercingsilence.vmdl', 'attach_attack1', offset, direction, scale, animation)
      --]]
    elseif npc:GetUnitName() == "npc_dota_hero_life_stealer" then
      function createspike(i, j)
        j = j + RandomFloat(-0.9, 0.9)
        i = i + RandomFloat(-0.9, 0.9)
        local spike = AttachManager:AttachModel(
          npc, 
          'models/heroes/sand_king/sand_king_spike.vmdl',
          'attach_hitloc', 
          Vector(RandomFloat(1, 5), j * 5, -i * 16 - 8), 
          Vector(0, 0, 0), 
          RandomFloat(0.2, 0.4), 
          'bindPose'
        )
      end
      for i = -1, 2 do
        for j = -2, 2 do
          createspike(i, j)
        end
      end
    end
    if npc:GetUnitName() == "npc_dota_hero_bane" then
      return
    end
    local sent_values = {}
		Timers:CreateTimer(function()
        for i=0, 16 do
          local ability = npc:GetAbilityByIndex(i)
          if ability ~= nil and ability:GetSpecialValueFor("health_cost") ~= 0 and sent_values[i] ~= ability:GetLevel() then
            sent_values[i] = ability:GetLevel()
            CustomGameEventManager:Send_ServerToPlayer(npc:GetPlayerOwner(), "health_cost_set", {index=i, cost=ability:GetSpecialValueFor("health_cost")})
          end
        end

				local universal_ability = npc:FindAbilityByName("ability_universal_ability")
				
        if npc.loadout_stats == nil then
          npc.loadout_stats = {}
        end

        if npc.loadout_stats['armour'] == nil then npc.loadout_stats['armour'] = 0 end
        if npc.loadout_stats['life'] == nil then npc.loadout_stats['life'] = 0 end
        if npc.loadout_stats['life%'] == nil then npc.loadout_stats['life%'] = 0 end
        if npc.loadout_stats['life regeneration'] == nil then npc.loadout_stats['life regeneration'] = 0 end
        if npc.loadout_stats['magic resistance'] == nil then npc.loadout_stats['magic resistance'] = 0 end
        if npc.loadout_stats['attack damage'] == nil then npc.loadout_stats['attack damage'] = 0 end
        if npc.loadout_stats['attack speed'] == nil then npc.loadout_stats['attack speed'] = 0 end
        if npc.loadout_stats['unique passive'] == nil then npc.loadout_stats['unique passive'] = {} end

        for k, passive_name in pairs(npc.loadout_stats['unique passive']) do
          universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_unique_passive_" .. passive_name, { })
        end

				universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_armour", { })
				universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_magic_resistance", { })
				local level = npc:GetLevel()

				if level > 1 then
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_health", { })
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_health_regen", { })
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_attack_damage", { })
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_attack_speed", { })

					npc:SetModifierStackCount("modifier_hidden_level_health",            universal_ability, (npc:GetLevel() - 1) * level_health_application_ratios[npc:GetName()]                )
					npc:SetModifierStackCount("modifier_hidden_level_health_regen",      universal_ability, (npc:GetLevel() - 1) * level_health_regen_application_ratios[npc:GetName()] * 100 / 5)
					npc:SetModifierStackCount("modifier_hidden_level_attack_damage",     universal_ability, (npc:GetLevel() - 1) * level_attack_damage_application_ratios[npc:GetName()] * 10    )
					npc:SetModifierStackCount("modifier_hidden_level_attack_speed",      universal_ability, (npc:GetLevel() - 1) * level_attack_speed_application_ratios[npc:GetName()]          )
				else
          npc:SetModifierStackCount("modifier_hidden_level_health",            universal_ability, 0)
          npc:SetModifierStackCount("modifier_hidden_level_health_regen",      universal_ability, 0)
          npc:SetModifierStackCount("modifier_hidden_level_attack_damage",     universal_ability, 0)
          npc:SetModifierStackCount("modifier_hidden_level_attack_speed",      universal_ability, 0)
        end

        if npc.loadout_stats["life"] > 0 then              universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_health", { })        end
        if npc.loadout_stats["life regeneration"] > 0 then universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_health_regen", { })  end
        if npc.loadout_stats["attack damage"] > 0 then     universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_attack_damage", { }) end
        if npc.loadout_stats["attack speed"] > 0 then      universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_level_attack_speed", { })  end
        npc:SetModifierStackCount("modifier_hidden_level_health",            universal_ability, npc:GetModifierStackCount("modifier_hidden_level_health", universal_ability) +        npc.loadout_stats['life'])
        npc:SetModifierStackCount("modifier_hidden_level_health_regen",      universal_ability, npc:GetModifierStackCount("modifier_hidden_level_health_regen", universal_ability) +  npc.loadout_stats['life regeneration'])
        npc:SetModifierStackCount("modifier_hidden_level_attack_damage",     universal_ability, npc:GetModifierStackCount("modifier_hidden_level_attack_damage", universal_ability) + npc.loadout_stats['attack damage'])
        npc:SetModifierStackCount("modifier_hidden_level_attack_speed",      universal_ability, npc:GetModifierStackCount("modifier_hidden_level_attack_speed", universal_ability) +  npc.loadout_stats['attack speed'])
        npc:SetModifierStackCount("modifier_hidden_level_health",            universal_ability, npc:GetModifierStackCount("modifier_hidden_level_health", universal_ability) +        npc.loadout_stats['life%'] / 100 * npc:GetMaxHealth())


        if level > 9 and npc.hasLevel9Point ~= true and npc:IsAlive() then
          npc.hasLevel9Point = true
          npc.spell_points = npc.spell_points + 1
          npc:SetAbilityPoints(npc:GetAbilityPoints() - 1)
          CustomGameEventManager:Send_ServerToPlayer(npc:GetPlayerOwner(), "add_spell_point", {})
        end
        if level > 19 and npc.hasLevel20Point ~= true and npc:IsAlive() then
          npc.hasLevel20Point = true
          npc.spell_points = npc.spell_points + 1
          npc:SetAbilityPoints(npc:GetAbilityPoints() - 1)
          CustomGameEventManager:Send_ServerToPlayer(npc:GetPlayerOwner(), "add_spell_point", {})
        end

				npc:SetModifierStackCount("modifier_hidden_level_armour",            universal_ability, (npc:GetLevel() - 1) * level_armour_application_ratios[npc:GetName()]                 + npc.loadout_stats['armour'])
				npc:SetModifierStackCount("modifier_hidden_level_magic_resistance",  universal_ability, (npc:GetLevel() - 1) * level_magic_resistance_application_ratios[npc:GetName()]       + npc.loadout_stats['magic resistance'])
				npc:SetModifierStackCount("modifier_hidden_level_armour",            universal_ability, initial_armour_application_ratios[npc:GetName()]           + npc:GetModifierStackCount("modifier_hidden_level_armour", npc)          )
				npc:SetModifierStackCount("modifier_hidden_level_magic_resistance",  universal_ability, initial_magic_resistance_application_ratios[npc:GetName()] + npc:GetModifierStackCount("modifier_hidden_level_magic_resistance", npc))
				
				local haste = find_stat(npc, "haste")
				local base_ms = haste * 0.4
				if base_ms == 0 then
					npc:RemoveModifierByName("modifier_hidden_haste_movespeed")
				else
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_haste_movespeed", { })
					npc:SetModifierStackCount("modifier_hidden_haste_movespeed", universal_ability, base_ms)
				end
        if haste_attack_speed_application_ratios[npc:GetUnitName()] == nil then
          return 1 / 30
        end
				local base_as = haste * haste_attack_speed_application_ratios[npc:GetUnitName()]

        local total_multiplier = 1

        for k, v in pairs(statfinder_modifier_table) do
          for k2, v2 in ipairs(v) do
            if v2[1] == "added_attackspeed_percent" then
              local modifier = npc:FindModifierByName(k)
              if modifier ~= nil then
                total_multiplier = total_multiplier * (1 + v2[1 + modifier:GetAbility():GetLevel()])
              end
            end
          end
        end
        npc:RemoveModifierByName("modifier_hidden_percent_negative_attack_speed")
        npc:RemoveModifierByName("modifier_hidden_percent_positive_attack_speed")
        local old_aps = npc:GetAttacksPerSecond()
        if total_multiplier > 1 then
          universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_percent_positive_attack_speed", {})
          while npc:GetAttacksPerSecond() < old_aps * total_multiplier do
            npc:SetModifierStackCount("modifier_hidden_percent_positive_attack_speed", npc, npc:GetModifierStackCount("modifier_hidden_percent_negative_attack_speed", caster) + 1)
          end
        elseif total_multiplier < 1 then
          universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_percent_negative_attack_speed", {})
          while npc:GetAttacksPerSecond() > old_aps * total_multiplier do
            npc:SetModifierStackCount("modifier_hidden_percent_negative_attack_speed", npc, npc:GetModifierStackCount("modifier_hidden_percent_negative_attack_speed", caster) + 1)
          end
        end

				if base_as == 0 then
					npc:RemoveModifierByName("modifier_hidden_power_attack_speed")
				else
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_power_attack_speed", { })
					npc:SetModifierStackCount("modifier_hidden_power_attack_speed", universal_ability, base_as)
				end
				
				local power = find_stat(npc, "power")
				local base_damage = power * power_attack_damage_application_ratios[npc:GetUnitName()]
				local universal_ability = npc:FindAbilityByName("ability_universal_ability")
				if base_damage <= 0 then
					npc:RemoveModifierByName("modifier_hidden_power_attack_damage")
				else
					universal_ability:ApplyDataDrivenModifier(npc, npc, "modifier_hidden_power_attack_damage", { })
					npc:SetModifierStackCount("modifier_hidden_power_attack_damage", universal_ability, base_damage)
				end

        local event_data = {
            power = math.ceil(find_stat(npc, "power")),
	          haste = math.ceil(find_stat(npc, "haste")),
	          precision = math.ceil(find_stat(npc, "precision")),
	          mastery = math.ceil(find_stat(npc, "mastery")),
	          lifedrain = math.ceil(find_stat(npc, "lifedrain")),
	          armour = math.ceil(find_stat(npc, "armour")),
	          magic_resistance = math.ceil(find_stat(npc, "magic_resistance")),
	          defense_penetration = math.ceil(find_stat(npc, "defense_penetration")),

            attack_speed = math.ceil(find_stat(npc, "haste")) * haste_attack_speed_application_ratios[npc:GetUnitName()],
            cooldown_reduction = math.ceil(find_stat(npc, "haste")) * haste_cooldown_application_ratios[npc:GetUnitName()],

            defense_penetration = math.ceil(find_stat(npc, "defense_penetration")),
            power_attack_damage_application_ratio = math.ceil(power_attack_damage_application_ratios[npc:GetUnitName()]),
            mastery = math.ceil(find_stat(npc, "mastery")),
            lifedrain = math.ceil(find_stat(npc, "lifedrain")),
        }

        if PlayerResource:IsValidPlayer(npc:GetPlayerID()) then
          CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(npc:GetPlayerID()), "SpiritgateTickStats", event_data )

          local units_to_add = {}

          local units={
          }

          local all_units = GetUnitsInRadiusOfPoint(Vector(0, 0, 0), DOTA_TEAM_NEUTRALS, 1500000, false)

          for k, creep_unit in pairs(all_units) do
            if creep_unit:GetUnitName() == "npc_creep_melee" or creep_unit:GetUnitName() == "npc_creep_ranged" or creep_unit:GetUnitName() == "npc_well_worker" or creep_unit:GetUnitName() == "npc_binding" then
              if npc:CanEntityBeSeenByMyTeam(creep_unit) then
                units_to_add[#units_to_add + 1] = creep_unit
              end
            end
          end

          for k, unit in pairs(units_to_add) do
            local unit_type = "creep"
            if unit:GetUnitName() == "npc_binding" then unit_type = "binding" end
            units[#units + 1] = { pos = unit:GetAbsOrigin(), name = unit:GetUnitName(), angle = math.atan2(unit:GetForwardVector().y, unit:GetForwardVector().x) * 180 / math.pi, type=unit_type, team=unit:GetTeamNumber()}
          end

          for i=0,9 do
            local check_player = PlayerResource:GetPlayer(i)
            if check_player ~= nil then
              local check_player_hero = check_player:GetAssignedHero()
              if npc:CanEntityBeSeenByMyTeam(check_player_hero) then
                units[#units + 1] = { pos = check_player_hero:GetAbsOrigin(), name = check_player_hero:GetUnitName(), angle = math.atan2(check_player_hero:GetForwardVector().y, check_player_hero:GetForwardVector().x) * 180 / math.pi, team=check_player_hero:GetTeamNumber()}
              end
            end
          end

          CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(npc:GetPlayerID()), "MinimapUpdateUnits", { 
            units = units,
            length = #units
          })
        end
        return 1 / 15.0
			end
		)
		npc.bFirstSpawned = true

		GameMode:OnHeroInGame(npc)
	end
	
	-- This internal handling is used to set up main barebones functions
	GameMode:_OnNPCSpawned(keys)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function GameMode:OnEntityHurt(keys)
  --DebugPrint("[BAREBONES] Entity Hurt")
  --DebugPrintTable(keys)
  
  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  --local entCause = EntIndexToHScript(keys.entindex_attacker) --BROKEN BECAUSE OF HERO SELECT
  --local entVictim = EntIndexToHScript(keys.entindex_killed)
end

-- An item was picked up off the ground
function GameMode:OnItemPickedUp(keys)
  DebugPrint( '[BAREBONES] OnItemPickedUp' )
  DebugPrintTable(keys)

  local heroEntity = EntIndexToHScript(keys.HeroEntityIndex)
  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function GameMode:OnPlayerReconnect(keys)
  DebugPrint( '[BAREBONES] OnPlayerReconnect' )
  DebugPrintTable(keys) 
  Timers:CreateTimer(5, function()
    CustomGameEventManager:Send_ServerToPlayer(EntIndexToHScript(keys.HeroEntityIndex), "SpiritgateGameStart", {})
  end)
end

-- An item was purchased by a player
function GameMode:OnItemPurchased( keys )
  DebugPrint( '[BAREBONES] OnItemPurchased' )
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function GameMode:OnAbilityUsed(keys)
	DebugPrint('[BAREBONES] AbilityUsed')
	DebugPrintTable(keys)

	local player = EntIndexToHScript(keys.PlayerID)
	local abilityname = keys.abilityname
 
	local hero = PlayerResource:GetPlayer( keys.PlayerID )
	local heroEntity = hero:GetAssignedHero()
    
  local universal_ability = heroEntity:FindAbilityByName("ability_universal_ability")

  local ability = heroEntity:FindAbilityByName( keys.abilityname )

  if ability == nil then --This skill is a consumable, don't run surge or reduce cd, etc.
      return nil
  end
  
  local ability_kv = LoadKeyValues("scripts/npc/abilities/" .. ability:GetAbilityName() .. ".txt")
  
  if ability:GetCooldownTimeRemaining() > 0 then
    ability:EndCooldown()
    ability:StartCooldown(math.max(0, get_ability_cooldown(heroEntity, ability)))
  end
	
	if heroEntity:HasAbility("ability_winters_bride_ice_lance") and ability:GetAbilityName() ~= "ability_universal_attack" then
		local ice_lance = heroEntity:FindAbilityByName("ability_winters_bride_ice_lance")
		ice_lance:ApplyDataDrivenModifier(heroEntity, heroEntity, "recent_cast_modifier", { })
	end
  if ability_kv.AbilityCannotSurge ~= 1 then
    local surge = find_stat(heroEntity, "surge")
    if surge > 0 and (not heroEntity:HasModifier("modifier_command_surge_cooldown")) then
        universal_ability:ApplyDataDrivenModifier(heroEntity, heroEntity, "modifier_command_surge_cooldown", { })
        universal_ability:ApplyDataDrivenModifier(heroEntity, heroEntity, "modifier_command_surge", { Duration = 4 })
        heroEntity:SetModifierStackCount("modifier_command_surge", universal_ability, heroEntity:GetModifierStackCount("modifier_command_surge", heroEntity) + surge)
        Timers:CreateTimer(4, function()
            heroEntity:SetModifierStackCount("modifier_command_surge", universal_ability, heroEntity:GetModifierStackCount("modifier_command_surge", heroEntity) - surge)
        end)
    end

    local item_justice = find_item(heroEntity, "item_justice")
    if item_justice ~= nil then
      if not heroEntity:HasModifier("item_justice_cooldown") then
        item_justice:ApplyDataDrivenModifier(heroEntity, heroEntity, "item_justice_power_overwhelming", {})
        item_justice:ApplyDataDrivenModifier(heroEntity, heroEntity, "item_justice_cooldown", {})
      end
    end
    local item_conquest = find_item(heroEntity, "item_conquest")
    if item_conquest ~= nil then
      if not heroEntity:HasModifier("item_conquest_aftermath_cooldown") then
        item_conquest:ApplyDataDrivenModifier(heroEntity, heroEntity, "item_conquest_aftermath_cooldown", {})
        item_conquest:ApplyDataDrivenModifier(heroEntity, heroEntity, "item_conquest_aftermath", {})
      end
    end
    if heroEntity:HasModifier("modifier_jungle_buff_haste") then
      universal_ability:ApplyDataDrivenModifier(heroEntity, heroEntity, "modifier_jungle_buff_haste_use_ability", {})
    end
  end
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function GameMode:OnNonPlayerUsedAbility(keys)
  DebugPrint('[BAREBONES] OnNonPlayerUsedAbility')
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function GameMode:OnPlayerChangedName(keys)
  DebugPrint('[BAREBONES] OnPlayerChangedName')
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function GameMode:OnPlayerLearnedAbility( keys)
  DebugPrint('[BAREBONES] OnPlayerLearnedAbility')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function GameMode:OnAbilityChannelFinished(keys)
  DebugPrint('[BAREBONES] OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function GameMode:OnPlayerLevelUp(keys)
	DebugPrint('[BAREBONES] OnPlayerLevelUp')
	DebugPrintTable(keys)

	local player = EntIndexToHScript(keys.player)
	local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function GameMode:OnLastHit(keys)
  DebugPrint('[BAREBONES] OnLastHit')
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local target = EntIndexToHScript(keys.EntKilled)
  local caster = PlayerResource:GetSelectedHeroEntity(keys.PlayerID)

  if caster == nil then return end

  local universal_ability = caster:FindAbilityByName("ability_universal_ability")

  local old_gold = caster:GetGold()

  if bounty_application_ratios[target:GetUnitName()] ~= nil then
    local modifier = 1
    if target:GetUnitName() == "npc_well_worker" and caster:HasModifier("modifier_role_predator") then
      modifier = modifier * 2
    end
    caster:ModifyGold((bounty_application_ratios[target:GetUnitName()] + bounty_application_ratios_nearby[target:GetUnitName()]) * modifier, true, 0)
  end

  if (target:GetUnitName() == "npc_creep_melee" or target:GetUnitName() == "npc_creep_ranged") and caster:HasModifier("modifier_role_gladiator") then
    caster:ModifyGold(bounty_application_ratios[target:GetUnitName()] + caster:GetModifierStackCount("modifier_role_gladiator", universal_ability), true, 0)
    caster:SetModifierStackCount("modifier_role_gladiator", universal_ability, 0)
    caster.gladiator_gold_stacks = 0
  end
  
  if target.is_jungle_creep and caster:HasModifier("modifier_role_hunter") then
    dofile("deal_damage")
    deal_damage_heal(caster, caster, target:GetMaxHealth() * 0.025, 0, 0)
    if RandomInt(1, 100) < 25 then
      caster:ModifyGold(30, true, 0)
    end
  end

  local gained_gold = caster:GetGold() - old_gold
  SendOverheadEventMessage(player, 0, target, gained_gold, player)
end

-- A tree was cut down by tango, quelling blade, etc
function GameMode:OnTreeCut(keys)
  DebugPrint('[BAREBONES] OnTreeCut')
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A rune was activated by a player
function GameMode:OnRuneActivated (keys)
  DebugPrint('[BAREBONES] OnRuneActivated')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

-- A player took damage from a tower
function GameMode:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[BAREBONES] OnPlayerTakeTowerDamage')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function GameMode:OnPlayerPickHero(keys)
  DebugPrint('[BAREBONES] OnPlayerPickHero')
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function GameMode:OnTeamKillCredit(keys)
  DebugPrint('[BAREBONES] OnTeamKillCredit')
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end

function OnAssist(caster, target)
  dofile("deal_damage")
  local item_assimilation = find_item(caster, "item_assimilation")
  if item_assimilation ~= nil then
    amount = find_stat(caster, "power") + 75
    local heals = GetFriendliesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), 1200)
    for _, heal_target in pairs(heals) do
      deal_damage_heal(caster, heal_target, amount, 0, 0)
    end
  end
  local item_grace = find_item(caster, "item_grace")
  if item_grace ~= nil then
    local buff_targets = GetFriendliesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), 1200)
    for _, buff_target in pairs(buff_targets) do
      item_grace:ApplyDataDrivenModifier(caster, buff_target, "item_grace_ms_buff", {})
    end
  end
  if caster:HasAbility("ability_pure_shaper_shadow_fury") then
    for i=0,2 do
      caster:GetAbilityByIndex(i):EndCooldown()
    end
  end
end

-- An entity died
function GameMode:OnEntityKilled( keys )
	DebugPrint( '[BAREBONES] OnEntityKilled Called' )
	DebugPrintTable( keys )

	GameMode:_OnEntityKilled( keys )
  

	-- The Unit that was Killed
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	-- The Killing entity
	local killerEntity = nil

	if keys.entindex_attacker ~= nil then
		killerEntity = EntIndexToHScript( keys.entindex_attacker )
	end

	local damagebits = keys.damagebits -- This might always be 0 and therefore useless
	
  if killedUnit:IsHero() and killedUnit.kill_assist_timers ~= nil then
    for unit, timer in pairs(killedUnit.kill_assist_timers) do
      OnAssist(unit, killedUnit)
    end
  end

	local nearby_enemies = FindUnitsInRadius(killedUnit:GetTeam(), killedUnit:GetAbsOrigin(), nil, 1400, 
		DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	for i, nearby_enemy in ipairs(nearby_enemies) do
    nearby_enemy:FindAbilityByName("ability_universal_ability")
		for i = 0, 5 do
			if nearby_enemy:GetItemInSlot(i) ~= nil then
				local consume_health = nearby_enemy:GetItemInSlot(i):GetSpecialValueFor("added_consume_health")
				local consume_chance = nearby_enemy:GetItemInSlot(i):GetSpecialValueFor("added_consume_chance")
				if math.random() <= consume_chance then 
          if nearby_enemy:IsRangedAttacker() then
            deal_damage_heal(nearby_enemy, nearby_enemy, consume_health, 0, 0)
          else
            deal_damage_heal(nearby_enemy, nearby_enemy, consume_health * 2, 0, 0)
          end
				end
			end
		end

    if killedUnit:GetUnitName() == "npc_creep_melee" and nearby_enemy:IsHero() then
      local gold_base = bounty_application_ratios_nearby[killedUnit:GetUnitName()]
      if nearby_enemy:HasModifier("modifier_role_tactician") then
        gold_base = gold_base * 2
      end
      if (nearby_enemy.gladiator_gold_stacks == nil or nearby_enemy.gladiator_gold_stacks < 3) and 
          nearby_enemy ~= killerEntity and 
          not nearby_enemy:IsRangedAttacker() and
          nearby_enemy:HasModifier("modifier_role_gladiator") then
        local bounty = bounty_application_ratios[killedUnit:GetUnitName()]
        if nearby_enemy.gladiator_gold_stacks == nil then nearby_enemy.gladiator_gold_stacks = 0 end
        nearby_enemy.gladiator_gold_stacks = nearby_enemy.gladiator_gold_stacks + 1
        local stacks = bounty + nearby_enemy:GetModifierStackCount("modifier_role_gladiator", enemy_universal_ability)
        nearby_enemy:SetModifierStackCount("modifier_role_gladiator", enemy_universal_ability, stacks)
      end
      if killerEntity ~= nearby_enemy then
        nearby_enemy:ModifyGold(gold_base, true, 0)
        SendOverheadEventMessage(nearby_enemy:GetPlayerOwner(), 0, killedUnit, gold_base, nearby_enemy:GetPlayerOwner())
      end
    end
    if killedUnit:GetUnitName() == "npc_creep_ranged" and nearby_enemy:IsHero() then
      local gold_base = bounty_application_ratios_nearby[killedUnit:GetUnitName()]
      if nearby_enemy:HasModifier("modifier_role_tactician") then
        gold_base = gold_base * 2
      end
      if (nearby_enemy.gladiator_gold_stacks == nil or nearby_enemy.gladiator_gold_stacks < 3) and 
          nearby_enemy ~= killerEntity and 
          not nearby_enemy:IsRangedAttacker() and
          nearby_enemy:HasModifier("modifier_role_gladiator") then
        local bounty = bounty_application_ratios[killedUnit:GetUnitName()]
        if nearby_enemy.gladiator_gold_stacks == nil then nearby_enemy.gladiator_gold_stacks = 0 end
        nearby_enemy.gladiator_gold_stacks = nearby_enemy.gladiator_gold_stacks + 1
        local stacks = bounty + nearby_enemy:GetModifierStackCount("modifier_role_gladiator", enemy_universal_ability)
        nearby_enemy:SetModifierStackCount("modifier_role_gladiator", enemy_universal_ability, stacks)
      end
      if killerEntity ~= nearby_enemy then
        nearby_enemy:ModifyGold(gold_base, true, 0)
        SendOverheadEventMessage(nearby_enemy:GetPlayerOwner(), 0, killedUnit, gold_base, nearby_enemy:GetPlayerOwner())
      end
    end
	end

  local caster = killerEntity
  if caster ~= nil and killedUnit:GetUnitName() == "npc_jungle_cute_shroom" then
    caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "modifier_jungle_buff_haste", {})
  end
  if caster ~= nil and killedUnit:GetUnitName() == "npc_jungle_ugly_ugger" then
    caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "modifier_jungle_buff_armour", {})
  end
  if caster ~= nil and killedUnit:GetUnitName() == "npc_jungle_scary_fish" then
    caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, caster, "modifier_jungle_buff_power", {})
  end

  if killedUnit:IsHero() then
    CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(killedUnit:GetPlayerID()), "UpdateStore", {active = true})
  end 
end



-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function GameMode:PlayerConnect(keys)
  DebugPrint('[BAREBONES] PlayerConnect')
  DebugPrintTable(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function GameMode:OnConnectFull(keys)
  DebugPrint('[BAREBONES] OnConnectFull')
  DebugPrintTable(keys)

  GameMode:_OnConnectFull(keys)
  
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function GameMode:OnIllusionsCreated(keys)
  DebugPrint('[BAREBONES] OnIllusionsCreated')
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function GameMode:OnItemCombined(keys)
  DebugPrint('[BAREBONES] OnItemCombined')
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function GameMode:OnAbilityCastBegins(keys)
  DebugPrint('[BAREBONES] OnAbilityCastBegins')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever a tower is killed
function GameMode:OnTowerKill(keys)
  DebugPrint('[BAREBONES] OnTowerKill')
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

-- This function is called whenever a player changes there custom team selection during Game Setup 
function GameMode:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('[BAREBONES] OnPlayerSelectedCustomTeam')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function GameMode:OnNPCGoalReached(keys)
  DebugPrint('[BAREBONES] OnNPCGoalReached')
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end