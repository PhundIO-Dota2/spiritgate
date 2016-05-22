universal_shields = {
    "modifier_dreamwrap"
}

function damage( event )
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local damage = event.Damage
	local powerRatio = event.PowerRatio
    local healthRatio = event.HealthRatio

    if event.AbilityOverride ~= nil then
        ability = event.AbilityOverride
    end

	local isDoT = false
	if event.DoT == 1 then
		isDoT = true
	end
    local isAoE = false
	if event.AoE == 1 then
		isAoE = true
	end
    local damage_type = 1
    if event.AbilityOverride ~= nil then
        damage_type = 2
    else
        damage_type = ability:GetAbilityDamageType()
    end
    
    if event.DamageTypeOverride ~= nil then
        damage_type = event.DamageTypeOverride
    end
	deal_damage(caster, target, damage, powerRatio, damage_type, ability, isDoT, false, isAoE, healthRatio)
end

function autoattack_damage(event)
	local chance_to_crit = find_stat(event.caster, "mastery")
	local crit_damage = 2 + 2 * find_stat(event.caster, "obliterate")
	if RandomInt(0,100) < chance_to_crit then
		autoattack_damage_multi(event, crit_damage)
	else
		autoattack_damage_multi(event, 1)
	end
end
function GetBasicAttackDamage(npc)
    local power_ratio = 0
    if npc:IsHero() then
        power_ratio = power_attack_damage_application_ratios[npc:GetUnitName()]
    else 
        power_ratio = 1
    end
    return find_stat(npc, "attack_damage") + find_stat(npc, "power") * power_ratio
end
function autoattack_damage_multi(event, multiplier)
	local caster = event.caster
	local target = event.target
	local isCrit = false
	if multiplier > 1 then
		isCrit = true
	end
	
	local power_ratio = 0
	if caster:IsHero() then
		power_ratio = power_attack_damage_application_ratios[caster:GetUnitName()]
	else 
		power_ratio = 1
	end
	local basic_attack_damage = GetBasicAttackDamage(caster)
	if multiplier ~= nil then basic_attack_damage = basic_attack_damage * multiplier end
	
	local toughnessII = 1 - find_unique_passive(target, "toughnessII") --ToughnessII
	basic_attack_damage = basic_attack_damage * toughnessII
    local toughnessIII = 1 - find_unique_passive(target, "toughnessIII") --ToughnessII
    basic_attack_damage = basic_attack_damage * toughnessIII

	deal_damage(caster, target, basic_attack_damage - find_unique_passive(target, "damage_blocked"), 0, 1, nil, false, isCrit, false)
end

function deal_damage(caster, target, damage, powerRatio, damage_type, ability, isDoT, isCrit, isAoE, healthRatio)
    if target:IsNull() or not target:IsAlive() then
        return
    end

    add_kill_assist(caster, target)

    if target.is_jungle_creep then
        target.jungle_creep_activated = true
    end

    local universal_ability = caster:FindAbilityByName("ability_universal_ability")
	if universal_ability == nil then 
		print("COULD NOT FIND ABILITY_UNIVERSAL_ABILITY ON CASTER IN DEAL_DAMAGE. SOMETHING IS VERY WRONG PERMISSION TO PANIC: GRANTED")
		return nil
	end

    universal_ability:ApplyDataDrivenModifier(caster, caster, "universal_in_combat", {})
    universal_ability:ApplyDataDrivenModifier(target, target, "universal_in_combat", {})

	local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.damage_type = damage_type
	damage_table.ability = ability	
	damage_table.damage = damage + math.max(0, find_stat(caster, "power")) * powerRatio
    if healthRatio ~= nil then
        damage_table.damage = damage + caster:GetMaxHealth() * healthRatio
    end
    if caster:HasModifier("modifier_role_hunter") and target.is_jungle_creep then
        damage_table.damage = damage_table.damage * 1.1
    end
    
    if target.finesse_table ~= nil and target.finesse_table[caster] ~= nil then
        local stacks = 0
        for i = 1, 50 do
            if target.finesse_table[caster][i] then
                stacks = stacks + 1
            end
        end
        stacks = math.min(5, stacks)
        damage_table.damage = damage_table.damage + damage_table.damage * stacks * 0.05
    end

    if ability ~= nil then
        local bonus_armour_damage = find_stat(caster, "armour_as_damage")
        if bonus_armour_damage > 0 then
            local armour = find_stat(caster, "armour")
            local isDoTReduction = 1
            if isDoT then isDoTReduction = 0.33 end
            damage_table.damage = damage_table.damage + (armour * bonus_armour_damage) / 100.0 * isDoTReduction
        end
    end

    if damage_table.damage_type == 2 and target:HasModifier("modifier_chaos_magic_damage_increased") then
        damage_table.damage = damage_table.damage * 1.1
    end

    if caster:HasModifier("modifier_withered") then
        damage_table.damage = damage_table.damage * 0.7
    end

    local pre_damage_health = target:GetHealth()
	
    if ability == nil or ability:GetAbilityName() == "ability_universal_ability" then
        local precision = find_stat(caster, "precision")
        damage_table.damage = damage_table.damage + precision
    else
        local mastery = find_stat(caster, "mastery")
    	damage_table.damage = damage_table.damage * (1 + mastery / 200) --Ability Overload
        if caster:HasModifier("modifier_item_divinity_prodigy") then
            damage_table.damage = damage_table.damage * 1.075
        end
    end


    if target.knife_stuck_damage ~= nil and target.knife_stuck_damage > 0 and target.knife_stuck == caster then
        damage_table.damage = damage_table.damage * (100 + target.knife_stuck_damage) * 0.01
    end

	if damage_table.damage_type == 2 then --Magic Damage
        local target_magic_resistance = find_stat(target, "magic_resistance")
        if find_item(caster, "item_rage") then
            target_magic_resistance = target_magic_resistance / 2
        end
        local damage_multiplier_magic_pen = 100 / (100 + target_magic_resistance - find_stat(target, "defense_penetration"))
		damage_table.damage = damage_table.damage * damage_multiplier_magic_pen
		local void_percent = find_unique_passive(target, "void_percent")
		local void_reduction = math.min(10, damage_table.damage * void_percent / 100.0)
		damage_table.damage = damage_table.damage - void_reduction
	else --Physical Damage
        local target_armour = find_stat(target, "armour")
        if find_item(caster, "item_rage") then
            target_armour = target_armour / 2
        end
		local damage_multiplier_armor_pen = 100 / (100 + target_armour - find_stat(target, "defense_penetration"))
		damage_table.damage = damage_table.damage * damage_multiplier_armor_pen
	end
    local universal_shield_stacks = target:GetModifierStackCount("modifier_universal_shield", target)
    local pre_shield_damage = damage_table.damage
    damage_table.damage = damage_table.damage - universal_shield_stacks
    if damage_table.damage <= 0 then
        universal_shield_stacks = universal_shield_stacks - pre_shield_damage
        target:SetModifierStackCount("modifier_universal_shield", universal_ability, universal_shield_stacks)
        damage_table.damage = 0
    else 
        target:RemoveModifierByName("modifier_universal_shield")
    end
    local min_jungle_shield_stacks = target:GetModifierStackCount("modifier_min_jungle_shield", target)
    
    if caster.is_jungle_creep then
        damage_table.damage = damage_table.damage - min_jungle_shield_stacks / 3
    else
        damage_table.damage = damage_table.damage - min_jungle_shield_stacks
    end
    pre_shield_damage = damage_table.damage
    if damage_table.damage <= 0 then
        min_jungle_shield_stacks = min_jungle_shield_stacks - pre_shield_damage
        target:SetModifierStackCount("modifier_min_jungle_shield", universal_ability, min_jungle_shield_stacks)
        damage_table.damage = 0
    else 
        target:RemoveModifierByName("modifier_min_jungle_shield")
    end

    for _, modifier_name in ipairs(universal_shields) do
        local modifier_shield_stacks = target:GetModifierStackCount(modifier_name, target)
        local modifier_pre_shield_damage = damage_table.damage
        damage_table.damage = damage_table.damage - modifier_shield_stacks
        if damage_table.damage <= 0 then
            modifier_shield_stacks = modifier_shield_stacks - modifier_pre_shield_damage
            target:SetModifierStackCount(modifier_name, universal_ability, modifier_shield_stacks)
            damage_table.damage = 0
        else 
            target:RemoveModifierByName(modifier_name)
        end
    end

    if damage_table.damage_type == 2 then
        local arcane_aegis_stacks = target:GetModifierStackCount("modifier_arcane_aegis", target)
        local faith_item = find_item(target, "item_faith")
        damage_table.damage = damage_table.damage - arcane_aegis_stacks
        if damage_table.damage <= 0 then
            arcane_aegis_stacks = arcane_aegis_stacks - pre_shield_damage
            target:SetModifierStackCount("modifier_arcane_aegis", faith_item, arcane_aegis_stacks)
            damage_table.damage = 0
        else 
            target:RemoveModifierByName("modifier_arcane_aegis")
        end
    end

    
    --:Hunger:
	if caster:HasModifier("modifier_hunger_life_leech") then --Life Leech (Not Life Drain, which is a percentage)
		local healAmount = 5
		if target:IsHero() then
			healAmount = healAmount * 2
		end

        deal_damage_heal(caster, caster, healAmount, 0, 0)

		caster:RemoveModifierByName("modifier_hunger_life_leech")
        Timers:CreateTimer(0.5, function()
            find_item(caster, "item_hunger"):ApplyDataDrivenModifier(caster, caster, "modifier_hunger_life_leech", { })
        end)
	end

    if caster:HasModifier("modifier_ablative_damage_reduction") then
        damage_table.damage = damage_table.damage * 0.85
    end

    if caster:HasModifier("modifier_power_locked") then
        damage_table.damage = damage_table.damage * 0.9
    end

    local life_link_options = FindUnitsInRadius(target:GetTeamNumber(), target:GetAbsOrigin(), nil, 800, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for k, friendly in ipairs(life_link_options) do
        if friendly:GetHealth() / friendly:GetMaxHealth() > 0.25 and find_item(friendly, "item_empathy") then
            local taken_damage = damage_table.damage * 0.1
            damage_table.damage = damage_table.damage - taken_damage
            local link_damage_table = {}
            link_damage_table.attacker = caster
            link_damage_table.victim = friendly
            link_damage_table.damage_type = damage_type
            link_damage_table.ability = ability  
            link_damage_table.damage = taken_damage
            ApplyDamage(link_damage_table)
            break
        end
    end

    --:Retribution:
    if damage_table.damage_type == 2 and find_item(target, "item_retribution") then
        local item_retribution = find_item(target, "item_retribution")
        local stored = damage_table.damage * 0.1
        damage_table.damage = damage_table.damage - stored
        if stored >= 1 then
            item_retribution:ApplyDataDrivenModifier(target, target, "item_retribution_mage_slayer_stacks", {})
            target:SetModifierStackCount("item_retribution_mage_slayer_stacks", item_retribution, target:GetModifierStackCount("item_retribution_mage_slayer_stacks", item_retribution)+ stored)
        end
    end

    if (target:GetHealth() - damage_table.damage) / target:GetMaxHealth() < 0.3 and find_item(target, "item_valor") and not target:HasModifier("modifier_valor_last_stand_cooldown") then
        local item_valor = find_item(target, "item_valor")
        item_valor:ApplyDataDrivenModifier(target, target, "modifier_valor_last_stand_cooldown", {})
        item_valor:ApplyDataDrivenModifier(target, target, "modifier_valor_last_stand", {})
        target:SetModifierStackCount("modifier_valor_last_stand", item_valor, 350)
    end

    if target:HasModifier("modifier_valor_last_stand") then
        local stacks = target:GetModifierStackCount("modifier_valor_last_stand", target)
        local item_valor = find_item(target, "item_valor")
        local pre_shield_damage = damage_table.damage
        damage_table.damage = damage_table.damage - stacks
        if damage_table.damage <= 0 then
            stacks = stacks - pre_shield_damage
            target:SetModifierStackCount("modifier_valor_last_stand", item_valor, stacks)
            damage_table.damage = 0
        else 
            target:RemoveModifierByName("modifier_valor_last_stand")
        end
    end

    if caster:IsHero() and target:HasModifier("modifier_bad_dreams") and caster:GetUnitName() ~= "npc_dota_hero_meepo" then
        damage_table.damage = damage_table.damage + target.bad_dreams_damage
        target.bad_dreams_damage = nil
        target:RemoveModifierByName("modifier_bad_dreams")
    end

    --Lifedrain
    local drain_stat = find_stat(caster, "lifedrain")
    if ability ~= nil then
        drain_stat = drain_stat + find_unique_passive(caster, "added_ability_lifedrain")
    end
    local drain = drain_stat / 100.0 * damage_table.damage

    if find_item(caster, "item_creation") ~= nil then
        drain = drain * 1.3
    end
    if caster:HasModifier("modifier_mortal_strike") then
        drain = drain * 0.5
    end
    
    deal_damage_heal(caster, caster, drain, 0, 0)

    -- print("Dealing modified damage: " .. damage_table.damage)
    if isCrit then
        SendOverheadEventMessage(nil, 2 , target, damage_table.damage , nil) --crit text
    end

    if caster:HasModifier("modifier_item_insight_range_ticker") and not is_ability(ability) then
        damage_table.damage = damage_table.damage + GetBasicAttackDamage(caster) * 0.1
    end

    if target:HasModifier("modifier_jungle_buff_armour") then
        function tick_jungle_buff_armour()
            local jungle_buff_reduction_count = math.min(10, count_modifiers(target, "modifier_jungle_buff_armour_reduction_hidden"))
            target:SetModifierStackCount("modifier_jungle_buff_armour", universal_ability, jungle_buff_reduction_count)
        end
        tick_jungle_buff_armour()
        Timers:CreateTimer(3.01, tick_jungle_buff_armour)
        universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_jungle_buff_armour_reduction_hidden", {})
        damage_table.damage = damage_table.damage * (1 - 0.01 * math.min(10, count_modifiers(target, "modifier_jungle_buff_armour_reduction_hidden")))
    end

    if caster:FindAbilityByName("ability_pure_shaper_mark_of_consumption") and is_ability(ability) and ability:GetAbilityName() ~= "ability_universal_ability" and ability:GetAbilityName() ~= "ability_pure_shaper_mark_of_consumption" then
        caster:FindAbilityByName("ability_pure_shaper_mark_of_consumption"):ApplyDataDrivenModifier(caster, target, "modifier_mark_of_consumption", {})
        target.consumption_damage = 0
    end

    damage_table.damage = damage_table.damage * (1 + find_stat(target, "damage_taken"))

    local final_damage_dealt = damage_table.damage

    local streak_reward_gold = {
        22, -- -8
        32,
        46,
        65,
        93,
        132,
        189,
        270,
        300,
        350,
        400,
        450,
        500,
        550,
        560,
        570,
        580,
        590,
        600, --10
    }

    if final_damage_dealt > target:GetHealth() and target:IsHero() then
        local assistor_pids = {}
        for assistor, timer in pairs(target.kill_assist_timers) do
            assistor_pids[#assistor_pids + 1] = assistor:GetPlayerOwnerID()
        end
        local killer_data_sent = caster:GetUnitName()
        if caster:IsHero() then
            killer_data_sent = caster:GetPlayerOwnerID()
        end
        CustomGameEventManager:Send_ServerToAllClients("SpiritgateHeroKill", { 
            killer = killer_data_sent,
            killer_is_hero = caster:IsHero(),
            assistors = assistor_pids,
            dead_hero = target:GetPlayerOwnerID()
        })
        if caster:IsHero() then
            if caster.current_streak == nil then
                caster.current_streak = 0
            end
            if caster.current_streak < 0 then caster.current_streak = 0 end
            caster.current_streak = caster.current_streak + 1
        end
        if target.current_streak == nil then
            target.current_streak = 0
        end
        target:ForceKill(false)
        local gold_reward = streak_reward_gold[math.max(1, math.min(19, target.current_streak + 9))]
        local exp_reward = target:GetLevel() * 75 + 200 + RandomInt(0, 50)
        if caster:IsHero() then
            caster:IncrementKills(target:entindex())
            if caster:HasModifier("modifier_role_predator") then
                gold_reward = gold_reward * 1.5
                exp_reward = exp_reward * 1.3
            end
        end
        for assistor, timer in pairs(target.kill_assist_timers) do
            if assistor ~= caster and assistor:IsHero() then
                local assistor_gold_reward = (streak_reward_gold[math.max(1, math.min(19, target.current_streak + 9))]) / 2
                local assistor_exp_reward = (target:GetLevel() * 75 + 200 + RandomInt(0, 50)) / 2
                if assistor:HasModifier("modifier_role_predator") then
                    assistor_gold_reward = assistor_gold_reward * 2
                    assistor_exp_reward = assistor_exp_reward * 1.3
                end
                assistor:ModifyGold(assistor_gold_reward, true, DOTA_ModifyGold_HeroKill)
                assistor:AddExperience(assistor_exp_reward, DOTA_ModifyXP_HeroKill, false, true)
                SendOverheadEventMessage(assistor, OVERHEAD_ALERT_GOLD, assistor, assistor_gold_reward, nil)
            end
        end
        if caster:IsHero() then
            caster:ModifyGold(gold_reward, true, DOTA_ModifyGold_HeroKill)
            caster:AddExperience(exp_reward, DOTA_ModifyXP_HeroKill, false, true)
            SendOverheadEventMessage(caster, OVERHEAD_ALERT_GOLD, caster, gold_reward, nil)
        end

        if target.current_streak > 0 then target.current_streak = 0 end
        target.current_streak = target.current_streak - 1
    else
        ApplyDamage(damage_table)
    end

    deal_on_hit(caster, target, ability, damage_table.damage_type)

    if caster == target.loremaster_chainer and target.shapers_chained ~= nil and #target.shapers_chained > 0 then
        local old_damage_table_damage = damage_table.damage
        damage_table.damage = damage_table.damage * (1.15 - 0.15 * #target.shapers_chained)
        for k, enemy in ipairs(target.shapers_chained) do
            damage_table.victim = enemy
            if enemy ~= target then
                ApplyDamage(damage_table)
            end
        end
        damage_table.victim = target
        damage_table.damage = old_damage_table_damage
    end

    if target:HasModifier("modifier_ablative_armour") then
        local item_preservation = find_item(target, "item_preservation")
        item_preservation:ApplyDataDrivenModifier(target, caster, "modifier_ablative_damage_reduction", {})
        local stacks = target:GetModifierStackCount("modifier_ablative_armour", item_preservation)
        stacks = stacks - 1
        if stacks == 0 then
            target:RemoveModifierByName("modifier_ablative_armour")
        else
            target:SetModifierStackCount("modifier_ablative_armour", item_preservation, stacks)
        end
    end

    --:Adamance:
    if damage_type == DAMAGE_TYPE_PHYSICAL and find_item(target, "item_adamance") ~= nil then
        local item_adamance = find_item(target, "item_adamance")
        item_adamance:ApplyDataDrivenModifier(target, target, "modifier_adamance_lockdown", {})
        target:SetModifierStackCount("modifier_adamance_lockdown", item_adamance, target:GetModifierStackCount("modifier_adamance_lockdown", item_adamance) + 1)
        if target:GetModifierStackCount("modifier_adamance_lockdown", item_adamance) == 5 then
            local lockdown_targets = GetEnemiesInRadius(target, 350)
            for k, lockdown_target in ipairs(lockdown_targets) do
                item_adamance:ApplyDataDrivenModifier(target, lockdown_target, "modifier_adamance_lockdown_slow", {})
            end
            target:RemoveModifierByName("modifier_adamance_lockdown")
        end
    end
    
    --:balance:
    local will_thief = find_stat(caster, "will_thief")
    local will_thief_max_stacks = 5 --will_thief / 3 * 5
    if will_thief > 0 then
        universal_ability:ApplyDataDrivenModifier(caster, caster, "modifier_will_thief_gain", { Duration = 4 })
        universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_will_thief_lose", { Duration = 4 })
        caster:SetModifierStackCount("modifier_will_thief_gain", universal_ability, math.min(will_thief_max_stacks, caster:GetModifierStackCount("modifier_will_thief_gain", caster) + 1))
        target:SetModifierStackCount("modifier_will_thief_lose", universal_ability, math.min(will_thief_max_stacks, target:GetModifierStackCount("modifier_will_thief_lose", caster) + 1))
    end
    
    --:Resolve:
    if target:GetHealth() < target:GetMaxHealth() / 2 and (not target:HasModifier("modifier_shield_wall_cooldown")) then
        local shield_wall = find_stat(target, "shield_wall")
        if shield_wall > 0 then
            universal_ability:ApplyDataDrivenModifier(target, target, "modifier_shield_wall", { Duration = 4 })
            universal_ability:ApplyDataDrivenModifier(target, target, "modifier_shield_wall_cooldown", { })
            if shield_wall > 1 then
                target:SetModifierStackCount("modifier_shield_wall", universal_ability, shield_wall)
            end
        end
    end

    --:Hope:
    if find_item(target, "item_hope") and target:GetHealth() < target:GetMaxHealth()  / 2 and not target:HasModifier("item_hope_cooldown") then
        local hope_item = find_item(target, "item_hope")
        hope_item:ApplyDataDrivenModifier(target, target, "modifier_item_hope", { Duration = 3})
        local armour_stacks = find_stat(target, "armour") / 2
        local magic_resistance_atacks = find_stat(target, "magic_resistance") / 2
        hope_item:ApplyDataDrivenModifier(target, target, "item_hope_cooldown", {})
        hope_item.duration = 3
        hope_item.total_duration = 3
        hope_item.timer = Timers:CreateTimer(function()
            hope_item.duration = hope_item.duration - 1 / 30

            hope_item:ApplyDataDrivenModifier(target, target, "modifier_item_hope", { Duration = hope_item.duration})
            hope_item:ApplyDataDrivenModifier(target, target, "modifier_item_hope_stack_armour", { Duration = hope_item.duration})
            hope_item:ApplyDataDrivenModifier(target, target, "modifier_item_hope_stack_magic_resistance", { Duration = hope_item.duration})
            target:SetModifierStackCount("modifier_item_hope_stack_armour", hope_item, armour_stacks)
            target:SetModifierStackCount("modifier_item_hope_stack_magic_resistance", hope_item, magic_resistance_atacks)

            if hope_item.duration <= 0 then
                hope_item.duration = nil
                hope_item.timer = nil
                hope_item.total_duration = nil
                return nil
            end
            return 1 / 30
        end)
    end
    if caster:HasModifier("modifier_item_hope") and find_item(caster, "item_hope") then
        local hope_item = find_item(caster, "item_hope")
        if hope_item.total_duration < 6 then
            hope_item.total_duration = hope_item.total_duration + 1
            hope_item.duration = hope_item.duration + 1
        end
    end
    --:Rebirth:
    if find_item(target, "item_rebirth") ~= nil and target:GetHealth() < target:GetMaxHealth() * 0.3 and (not target:HasModifier("item_rebirth_cooldown"))  then
        local item = find_item(target, "item_rebirth")
        item:ApplyDataDrivenModifier(target, target, "item_rebirth_cooldown", { Duration = 120 })
        local recovery = target:GetMaxHealth() * 0.3
        local recovery_done = false
        Timers:CreateTimer(5, function()
            recovery_done = true
        end)
        Timers:CreateTimer(function()
            if recovery_done then return end
            deal_damage_heal(target, target, recovery / 30 / 5, 0, 0)
            return 1 / 30
        end)
    end
    
    --:Defiance:
    if find_item(target, "item_defiance") ~= nil then
        if target:GetHealth() <= target:GetMaxHealth() / 4 and pre_damage_health > target:GetMaxHealth() / 4 then --If health was above 25% and after damage wasn't
            for i=0, 2 do
                target:GetAbilityByIndex(i):EndCooldown()
            end
        end
    end
    
    --:Pestilence:
    if is_ability(ability) and caster:HasModifier("modifier_plague_host_host") and not target:HasModifier("modifier_pestilence_cooldown") then
        local host_power = find_stat(caster.plague_host, "power")
        local pestilence_done = false

        find_item(caster.plague_host, "item_pestilence"):ApplyDataDrivenModifier(caster, target, "modifier_pestilence_cooldown", { Duration = 4 })
        find_item(caster.plague_host, "item_pestilence"):ApplyDataDrivenModifier(caster, target, "modifier_pestilence_slow", { Duration = 2 })
        
        Timers:CreateTimer(2, function()
            pestilence_done = true
        end)
        Timers:CreateTimer(function()
            if pestilence_done then return end
            deal_damage(caster, target, (75 + host_power * 0.4) / 30, 0, 2, "PESTILENCE", true, false, false, 0)
            return 1 / 30
        end)
    end

    --Shock from :Energy:
    if is_ability(ability) and find_stat(caster, "shock") > 0 and (not caster:HasModifier("modifier_shield_shock_cooldown")) then
        universal_ability:ApplyDataDrivenModifier(caster, caster, "modifier_shield_shock_cooldown", { })
        local shock = find_stat(caster, "shock")
        local shock_damage = shock * 20
        local partID = ParticleManager:CreateParticle("particles/shock/shock.vpcf", PATTACH_CUSTOMORIGIN, target)
        ParticleManager:SetParticleControl(partID, 0, target:GetAbsOrigin() + Vector(0, 0, 250))
        --ParticleManager:SetParticleControl(partID, 1, target:GetAbsOrigin() + Vector(0, 0, 250))
        --ParticleManager:SetParticleControl(partID, 2, target:GetAbsOrigin() + Vector(0, 0, 250))
        --ParticleManager:SetParticleControl(partID, 3, target:GetAbsOrigin() + Vector(0, 0, 250))
        EmitSoundOn("item_EnergyShock", target)
        deal_damage(caster, target, shock_damage, 0.5, 2, "POTENCY", false, false)
    end

    --Shock from :Potency:
    if not isDoT and not isAoE and is_ability(ability) and find_item(caster, "item_potency") and (not caster:HasModifier("modifier_potency_cooldown")) then
        find_item(caster, "item_potency"):ApplyDataDrivenModifier(caster, caster, "modifier_potency_cooldown", { })
        local shock_damage = 20 + find_stat(caster, "power") * 0.5 + target:GetMaxHealth() * 0.05
        local partID = ParticleManager:CreateParticle("particles/potency/zuus_lightning_bolt.vpcf", PATTACH_CUSTOMORIGIN, target)
        ParticleManager:SetParticleControl(partID, 0, target:GetAbsOrigin() + Vector(0, 0, 200))
        ParticleManager:SetParticleControl(partID, 1, target:GetAbsOrigin() + Vector(0, 0, 1500))
        EmitSoundOn("item_EnergyShock", target)
        deal_damage(caster, target, shock_damage, 0, 2, "POTENCY", false, false)
    end

    if not isDoT and is_ability(ability) and ability ~= nil and find_item(caster, "item_decay") then
        find_item(caster, "item_decay"):ApplyDataDrivenModifier(caster, target, "item_decay_decaying", {})
        target.decay_taken = 0
    end
    
    -- :Harmony:
    local harmony = find_item(caster, "item_harmony")
    if harmony ~= nil then
        local nearby_allies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, 800, 
                                                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for i, ally in ipairs(nearby_allies) do
            if ally ~= caster then 
                harmony:ApplyDataDrivenModifier(caster, ally, "item_harmony_power", {})
            end
        end
    end
    if caster:HasModifier("item_harmony_modifier_aura") then
        local nearby_allies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, 800, 
                                                DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for i, ally in ipairs(nearby_allies) do
            if ally ~= caster and find_item(ally, "item_harmony") ~= nil then 
                if not ally:HasModifier("item_harmony_cooldown_cooldown") then
                    find_item(ally, "item_harmony"):ApplyDataDrivenModifier(caster, ally, "item_harmony_cooldown_cooldown", {})
                    for i = 0, 3 do
                        local ally_ability = ally:GetAbilityByIndex(i)
                        local ally_ability_time = (ally_ability:GetCooldownTimeRemaining() - 0.25)
                        ally_ability:EndCooldown()
                        ally_ability:StartCooldown(ally_ability_time)
                    end
                end
            end
        end
    end

    --:tactician:
    if target:IsHero() and caster:HasModifier("modifier_role_tactician") and not caster.tactician_cooldown then
        local gold_base = 40
        if caster:IsRangedAttacker() then gold_base = gold_base * 0.5 end
        caster:ModifyGold(gold_base, true, 0)
        caster.tactician_cooldown = true
        universal_ability:ApplyDataDrivenModifier(caster, caster, "modifier_role_tactician", { Duration = 5 })
        Timers:CreateTimer(5, function() 
            caster.tactician_cooldown = false 
            caster:RemoveModifierByName("modifier_role_tactician")
            universal_ability:ApplyDataDrivenModifier(caster, caster, "modifier_role_tactician", {})
        end)
    end

    if caster:IsHero() and target:IsHero() then
        local iTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
        local iType = DOTA_UNIT_TARGET_ALL
        local iFlag = DOTA_UNIT_TARGET_FLAG_NONE + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
        local iOrder = FIND_ANY_ORDER

        local units = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetAbsOrigin(), nil, 1800, iTeam, iType, iFlag, iOrder, false)
        for k, unit in ipairs(units) do
            if unit:GetUnitName() == "npc_binding" then
                if unit.target == nil or not unit.target:IsHero() then
                    unit.target = caster
                end
            end
        end
    end

    if caster:HasModifier("modifier_momentum_shaper") and is_ability(ability) then
        for i=0, 3 do
            local momentum_shaper_ability = caster:GetAbilityByIndex(i)
            if momentum_shaper_ability ~= ability then
                local new_time = math.max(0, momentum_shaper_ability:GetCooldownTimeRemaining() - 1)
                momentum_shaper_ability:EndCooldown()
                if new_time > 0 then
                    momentum_shaper_ability:StartCooldown(new_time)
                end
            end
        end
    end

    if caster:HasModifier("modifier_wind_shaper") and is_ability(ability) then
        local wind_shaper_ability = caster:GetAbilityByIndex(4)
        disable({
            caster = caster,
            target = target,
            Duration = 2,
            DisableModifier = "modifier_wind_shaper_slow",
            ability = wind_shaper_ability
        })
        target:SetModifierStackCount("modifier_wind_shaper_slow", caster, 25)
        local stacks_remaining = 25
        Timers:CreateTimer(function()
            target:SetModifierStackCount("modifier_wind_shaper_slow", caster, target:GetModifierStackCount("modifier_wind_shaper_slow", caster) - 1)
            stacks_remaining = stacks_remaining - 1
            if stacks_remaining == 0 then
                return
            end
            return 2 / 25
        end)
    end

    return final_damage_dealt
end

function deal_on_hit(caster, target, ability, damage_type)
    local universal_ability = caster:FindAbilityByName("ability_universal_ability")

    for i=0, 5 do
        local item = caster:GetItemInSlot(i)
        if item ~= nil then
            if item:GetAbilityName() == "item_pride" and should_propogate_on_hit(ability) then
                item:ApplyDataDrivenModifier(caster, target, "item_pride_modifier_blazing", {})
            end
        end
    end
    local item_vengeance = find_item(caster, "item_vengeance")
    if item_vengeance ~= nil and should_propogate_on_hit(ability) then
        require("items/vengeance_lua")
        VengeanceOnAttackLanded({
            caster = caster,
            target = target,
            ability = item_vengeance
        })
    end
    local inner_peace_stacks = find_stat(caster, "inner_peace") / 10
    if inner_peace_stacks > 0 then
        universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_inner_peace", { })
        target:SetModifierStackCount("modifier_inner_peace", universal_ability, target:GetModifierStackCount("modifier_inner_peace", caster) + inner_peace_stacks)
        Timers:CreateTimer(3, function()
            target:SetModifierStackCount("modifier_inner_peace", universal_ability, target:GetModifierStackCount("modifier_inner_peace", caster) - inner_peace_stacks)
            return nil
        end)
    end

    local equilibrium_item = find_item(caster, "item_equilibrium")
    if equilibrium_item ~= nil then
        equilibrium_item:ApplyDataDrivenModifier(caster, target, "modifier_equilibrium_subdued", {})
    end

    local subjugation_item = find_item(caster, "item_subjugation")
    if subjugation_item ~= nil then
        subjugation_item:ApplyDataDrivenModifier(caster, target, "modifier_power_locked", {})
    end

    local retribution_item = find_item(caster, "item_retribution") 
    if retribution_item ~= nil and ability ~= "RETRIBUTION" then
        require("items/retribution_lua")
        RetributionAttackLanded({
            caster = caster,
            target = target,
            ability = item_retribution
        })
    end

    local betrayal_item = find_item(caster, "item_betrayal")
    if betrayal_item ~= nil and should_propogate_on_hit(ability) then
        deal_damage(caster, target, 40, 0, 2, "BETRAYAL", false, false, false)
    end

    if find_item(caster, "item_judgement") then
        local item_judgement = find_item(caster, "item_judgement")
        if damage_type == 1 then
            item_judgement:ApplyDataDrivenModifier(caster, target, "item_judgement_sundering_strikes_armour_hit", {})
        else
            item_judgement:ApplyDataDrivenModifier(caster, target, "item_judgement_sundering_strikes_magic_resistance_hit", {})
        end
        if target.item_judgement_ticker == nil then
            target.item_judgement_ticker = Timers:CreateTimer(function()
                if not target:HasModifier("item_judgement_sundering_strikes_magic_resistance_hit") and not target:HasModifier("item_judgement_sundering_strikes_armour_hit") then
                    target:RemoveModifierByName("item_judgement_sundering_strikes_armour_visible")
                    target:RemoveModifierByName("item_judgement_sundering_strikes_magic_resistance_visible")
                    target.item_judgement_ticker = nil
                    return
                end
                local magic_resistance_hit_count = count_modifiers(target, "item_judgement_sundering_strikes_magic_resistance_hit")
                local armour_hit_count = count_modifiers(target, "item_judgement_sundering_strikes_armour_hit")
                if armour_hit_count > 0 then
                    item_judgement:ApplyDataDrivenModifier(caster, target, "item_judgement_sundering_strikes_armour_visible", {})
                    target:SetModifierStackCount("item_judgement_sundering_strikes_armour_visible", caster, math.min(4, armour_hit_count))
                else
                    target:RemoveModifierByName("item_judgement_sundering_strikes_armour_visible")
                end
                if magic_resistance_hit_count > 0 then
                    item_judgement:ApplyDataDrivenModifier(caster, target, "item_judgement_sundering_strikes_magic_resistance_visible", {})
                    target:SetModifierStackCount("item_judgement_sundering_strikes_magic_resistance_visible", caster, math.min(4, magic_resistance_hit_count))
                else
                    target:RemoveModifierByName("item_judgement_sundering_strikes_magic_resistance_visible")
                end
                return 1 / 10
            end)
        end
    end
    --:Inevitability:
    local frost_item = find_item(caster, "item_inevitability")
    if frost_item ~= nil and ability ~= nil and (isAoE or isDoT) then --Frost AoE / DoT
        local f1 = find_unique_passive(caster, "ability_area_dot_target_percent_frost", true)
        if f1 < 0 then
            if target:HasModifier("modifier_frostII_melee") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_melee", { Duration = 1 })
            elseif target:HasModifier("modifier_frostII_single") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_single", { Duration = 1 })
            elseif target:HasModifier("modifier_frostII_ranged") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_ranged", { Duration = 1 })
            else
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_other", { Duration = 1 })
            end
        end
    elseif frost_item ~= nil and ability:GetAbilityName() == "ability_universal_ability" and caster:IsRangedAttacker() then --Frost Ranged Basic
        local f1 = find_unique_passive(caster, "ranged_basic_attack_percent_frost", true)
        if f1 < 0 then
            if target:HasModifier("modifier_frostII_melee") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_melee", { Duration = 1 })
            elseif target:HasModifier("modifier_frostII_single") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_single", { Duration = 1 })
            else
                if target:HasModifier("modifier_frostII_other") then
                    target:RemoveModifierByName("modifier_frostII_other")
                end
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_ranged", { Duration = 1 })
            end
        end
    elseif frost_item ~= nil and ability ~= nil then --Frost Single Target Ability
        local f1 = find_unique_passive(caster, "ability_single_target_percent_frost", true)
        if f1 < 0 then
            if target:HasModifier("modifier_frostII_melee") then
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_melee", { Duration = 1 })
            else
                if target:HasModifier("modifier_frostII_other") then
                    target:RemoveModifierByName("modifier_frostII_other")
                end
                if target:HasModifier("modifier_frostII_ranged") then
                    target:RemoveModifierByName("modifier_frostII_ranged")
                end
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_single", { Duration = 1 })
            end
        end
    elseif frost_item ~= nil then --Frost Melee Basic
        local f1 = find_unique_passive(caster, "melee_basic_attack_percent_frost", true)
        if f1 < 0 then
            if target:HasModifier("modifier_frostII_other") then
                target:RemoveModifierByName("modifier_frostII_other")
            end
            if target:HasModifier("modifier_frostII_ranged") then
                target:RemoveModifierByName("modifier_frostII_ranged")
            end
            if target:HasModifier("modifier_frostII_single") then
                target:RemoveModifierByName("modifier_frostII_single")
            end
            frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostII_melee", { Duration = 1 })
        end
    end

    --:Control:
    if frost_item == nil then
        frost_item = find_item(caster, "item_control")
        if ability ~= nil and (isAoE or isDoT) then --Frost AoE / DoT
            local f1 = find_unique_passive(caster, "ability_area_dot_target_percent_frost", true)
            if f1 < 0 then
                if target:HasModifier("modifier_frostI_melee") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_melee", { Duration = 1 })
                elseif target:HasModifier("modifier_frostI_single") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_single", { Duration = 1 })
                elseif target:HasModifier("modifier_frostI_ranged") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_ranged", { Duration = 1 })
                else
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_other", { Duration = 1 })
                end
            end
        elseif ability == nil or ability:GetAbilityName() == "ability_universal_ability" and caster:IsRangedAttacker() then --Frost Ranged Basic
            local f1 = find_unique_passive(caster, "ranged_basic_attack_percent_frost", true)
            if f1 < 0 then
                if target:HasModifier("modifier_frostI_melee") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_melee", { Duration = 1 })
                elseif target:HasModifier("modifier_frostI_single") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_single", { Duration = 1 })
                else
                    if target:HasModifier("modifier_frostI_other") then
                        target:RemoveModifierByName("modifier_frostI_other")
                    end
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_ranged", { Duration = 1 })
                end
            end
        elseif ability ~= nil then --Frost Single Target Ability
            local f1 = find_unique_passive(caster, "ability_single_target_percent_frost", true)
            if f1 < 0 then
                if target:HasModifier("modifier_frostI_melee") then
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_melee", { Duration = 1 })
                else
                    if target:HasModifier("modifier_frostI_other") then
                        target:RemoveModifierByName("modifier_frostI_other")
                    end
                    if target:HasModifier("modifier_frostI_ranged") then
                        target:RemoveModifierByName("modifier_frostI_ranged")
                    end
                    frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_single", { Duration = 1 })
                end
            end
        else --Frost Melee Basic
            local f1 = find_unique_passive(caster, "melee_basic_attack_percent_frost", true)
            if f1 < 0 then
                if target:HasModifier("modifier_frostI_other") then
                    target:RemoveModifierByName("modifier_frostI_other")
                end
                if target:HasModifier("modifier_frostI_ranged") then
                    target:RemoveModifierByName("modifier_frostI_ranged")
                end
                if target:HasModifier("modifier_frostI_single") then
                    target:RemoveModifierByName("modifier_frostI_single")
                end
                frost_item:ApplyDataDrivenModifier(caster, target, "modifier_frostI_melee", { Duration = 1 })
            end
        end
    end

    local item_pursuit = find_item(caster, "item_pursuit")
    if item_pursuit ~= nil then
        item_pursuit:ApplyDataDrivenModifier(caster, caster, "modifier_pursuit_positive", {})
        item_pursuit:ApplyDataDrivenModifier(caster, target, "modifier_pursuit_negative", {})
    end

    --:pain:
    local item_pain = find_item(caster, "item_pain")
    if item_pain ~= nil then
        universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_mortal_strike", {})
    end
    local item_corruption = find_item(caster, "item_corruption")
    if item_corruption ~= nil then
        universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_mortal_strike", {})
    end

    local item_conquest = find_item(caster, "item_conquest")
    if item_conquest ~= nil and caster:HasModifier("item_conquest_aftermath") and should_propogate_on_hit(ability) then
        require("items/conquest_lua")
        OnAttackLandedAftermath({
            caster = caster,
            target = target,
            ability = item_conquest
        })
    end

    local item_ruin = find_item(caster, "item_ruin")
    if item_ruin ~= nil and should_propogate_on_hit(ability) then
        require("items/ruin_lua")
        OnGiantKillerAttackLanded({
            caster = caster,
            target = target,
            ability = item_ruin
        })
    end

    local item_finesse = find_item(caster, "item_finesse")
    if item_finesse ~= nil and should_propogate_on_hit(ability) then
        require("items/finesse_lua")
        OnFinesseAttackLanded({
            caster = caster,
            target = target,
            ability = item_finesse
        })
    end

    local item_zeal = find_item(caster, "item_zeal")
    if item_zeal ~= nil and should_propogate_on_hit(ability) then
        require("items/zeal_lua")
        ZealAttackLanded({
            caster = caster,
            target = target,
            ability = item_zeal
        })
    end

    local item_duress = find_item(caster, "item_duress")
    if item_duress ~= nil and should_propogate_on_hit(ability) then
        require("items/duress_lua")
        DuressAttackLanded({
            caster = caster,
            target = target,
            ability = item_duress
        })
    end

    local item_chaos = find_item(caster, "item_chaos")
    if item_chaos ~= nil and should_propogate_on_hit(ability) then
        require("items/chaos_lua")
        OnChaosAttackLanded({
            caster = caster,
            target = target,
            ability = item_chaos
        })
    end

    local item_resonance = find_item(caster, "item_resonance")
    if item_resonance ~= nil and should_propogate_on_hit(ability) then
        require("items/resonance_lua")
        OnResonanceAttackLanded({
            caster = caster,
            target = target,
            ability = item_resonance
        })
    end

    local item_voracity = find_item(caster, "item_voracity")
    if item_voracity ~= nil and should_propogate_on_hit(ability) then
        require("items/voracity_lua")
        VoracityAttackLanded({
            caster = caster,
            target = target,
            ability = item_voracity
        })
    end
end

function should_propogate_on_hit(ability)
    return ability:GetAbilityName() == "ability_universal_ability" or ability == "FATE"
end

function is_ability(ability)
    return ability ~= nil and 
        ability ~= "SHOCK" and 
        ability ~= "POTENCY" and 
        ability ~= "CONQUEST" and 
        ability ~= "PESTILENCE" and
        ability ~= "RUIN" and 
        ability ~= "RESONANCE" and
        ability ~= "RETRIBUTION" and
        ability ~= "GLORY" and
        ability:GetAbilityName() ~= "ability_universal_ability"
end

function disable( event )
    local caster = event.caster
    local target = event.target

    if target:HasModifier("modifier_blitz") then
        return
    end

    local duration = event.Duration
    local power_ratio = event.DurationPowerRatio
    if power_ratio == nil then power_ratio = 0 end
    local modifier = event.DisableModifier
    local ability = event.ability

    add_kill_assist(caster, target)

    if event.UniversalAbility == 1 then ability = caster:FindAbilityByName("ability_universal_ability") end
    
    if target:HasModifier("modifier_momentum_disable_block") then
        target:RemoveModifierByName("modifier_momentum_disable_block")
        local momentum_item = find_item(target, "item_momentum")
        if momentum_item ~= nil then
            momentum_item:StartCooldown(30)
            Timers:CreateTimer(30, function()
                local applied = false
                Timers:CreateTimer(function()
                    if target:IsAlive() then
                        momentum_item:ApplyDataDrivenModifier(target, target, "modifier_momentum_disable_block", {})
                        applied = true
                    end
                    if applied then return end
                    return 0.5
                end)
            end)
        end
        return
    end

    local final_duration = duration + find_stat(caster, "power") * power_ratio
    local tenacity_mult = math.pow(0.7, find_stat(target, "tenacity") / 30) --Declining efficiency
    final_duration = final_duration * tenacity_mult

    --local partid = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
    ability:ApplyDataDrivenModifier(caster, target, modifier, { Duration = final_duration })

    Timers:CreateTimer(final_duration, function()
        --ParticleManager:DestroyParticle(partid, true)
        if find_item(target, "item_stability") then
            find_item(target, "item_stability"):ApplyDataDrivenModifier(target, target, "item_stability_swift_recovery", {})
        end
    end)
end

function deal_heal(event)
    deal_damage_heal({
        caster = event.caster,
        target = event.target,
        amount = event.Amount,
        power_ratio = event.PowerRatio,
        health_ratio = event.HealthRatio
    })
end

function deal_damage_heal(caster, target, amount, power_ratio, health_ratio)
    if power_ratio == nil then power_ratio = 0 end
    if health_ratio == nil then health_ratio = 0 end
    local heal_total = amount + find_stat(caster, "power") * power_ratio + caster:GetMaxHealth() * health_ratio
    if find_item(caster, "item_creation") ~= nil then
        heal_total = heal_total * 1.3
    end
    if target:HasModifier("modifier_mortal_strike") then
        heal_total = heal_total * 0.5
    end    
    if caster.pure_blood_modifier ~= nil then
        heal_total = heal_total * caster.pure_blood_modifier
    end
    if caster.health_shaper_pulse_effectiveness ~= nil then
        heal_total = heal_total * caster.health_shaper_pulse_effectiveness
    end

    if heal_total >= 0.1 then
        local pid = ParticleManager:CreateParticle("particles/healed/healed_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
        ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin())
    end
    

    target:Heal(heal_total, caster)
end

function add_kill_assist(caster, target)
    if caster:IsHero() then
        if target.kill_assist_timers == nil then
            target.kill_assist_timers = {}
        end
        if target.kill_assist_timers[caster] ~= nil then
            Timers:RemoveTimer(target.kill_assist_timers[caster])
        end
        target.kill_assist_timers[caster] = Timers:CreateTimer(15, function()
            Timers:RemoveTimer(target.kill_assist_timers[caster])
            target.kill_assist_timers[caster] = nil
        end)
    end
end