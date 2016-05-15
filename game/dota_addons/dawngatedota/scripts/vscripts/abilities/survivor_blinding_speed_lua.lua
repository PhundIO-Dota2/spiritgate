function on_spell_start(event)
    dofile("deal_damage")
    local caster = event.caster
    local ability = event.ability
    local target = event.target
    local rage_ability = caster:FindAbilityByName("ability_rage_shaper")

    local spd = 55

    if ability.recast then
        if caster:GetModifierStackCount("modifier_rage_stack", rage_ability) >= event.RageRequirement then
            caster:SetModifierStackCount("modifier_rage_stack", rage_ability, caster:GetModifierStackCount("modifier_rage_stack", rage_ability) - event.RageRequirement)
            Timers:RemoveTimer(ability.timer)
            ability.recast = false
            local origin = caster:GetAbsOrigin() 
            ability.pid = ParticleManager:CreateParticle("particles/freia_blinding_speed/blinding_speed_ability_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
            Timers:CreateTimer(function()
                local fv = -(caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
                if math_distance(caster:GetAbsOrigin(), target:GetAbsOrigin()) < 100 or math_distance(caster:GetAbsOrigin(), origin) > event.Range then
                    Timers:CreateTimer(1 / 15, function() ParticleManager:DestroyParticle(ability.pid, false) end)
                    FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
                    local targets = GetEnemiesInRadius(caster, event.Radius)
                    for k, target in ipairs(targets) do
                        deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
                    end

                    return nil
                else
                    caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
                end
                return 1 / 30
            end)
            ability:ApplyDataDrivenModifier(caster, caster, "modifier_survivor_blinding_speed_movement_speed", {})
        end
        --[[
        if target == ability.target_unit and caster:GetModifierStackCount("modifier_rage_stack", rage_ability) >= event.RageRequirement then
            caster:SetModifierStackCount("modifier_rage_stack", rage_ability, caster:GetModifierStackCount("modifier_rage_stack", rage_ability) - 50)
            Timers:RemoveTimer(ability.timer)
            local damage_remaining = event.Damage / event.Duration / 30 * (event.Duration * 30 - ability.ticks_passed)
            local damage_remaining_power_ratio = damage_remaining / event.Damage * event.DamagePowerRatio 
            damage_remaining = damage_remaining + damage_remaining_power_ratio * find_stat(caster, "power")
            deal_damage(caster, target, damage_remaining + event.RecastDamage + event.RecastDamagePowerRatio * find_stat(caster, "power"), 0, 1, ablility, false, false, false)
            ability.recast = false

            target:RemoveModifierByName("modifier_survivor_gouge_bleed")
            ability.target_unit = nil
        end
        --]]
        --ability:ApplyDataDrivenModifier(caster, target, "modifier_survivor_gouge_bleed", {})
    else
        local origin = caster:GetAbsOrigin() 
        ability.pid = ParticleManager:CreateParticle("particles/freia_blinding_speed/blinding_speed_ability_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        Timers:CreateTimer(function()
            local fv = -(caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
            if math_distance(caster:GetAbsOrigin(), target:GetAbsOrigin()) < 100 or math_distance(caster:GetAbsOrigin(), origin) > event.Range then
                FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
                Timers:CreateTimer(1 / 15, function() ParticleManager:DestroyParticle(ability.pid, false) end)
                local targets = GetEnemiesInRadius(caster, event.Radius)
                for k, target in ipairs(targets) do
                    deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
                end
                ability.recast = true
                ability.timer = Timers:CreateTimer(3, function()
                    ability.target_unit = nil 
                    ability.recast = false 
                    ability:StartCooldown(get_ability_cooldown(caster, ability))
                end)
                ability:EndCooldown()
                return nil
            else
                caster:SetAbsOrigin(caster:GetAbsOrigin() + fv * spd)
            end
            return 1 / 30
        end)
    end
end

function precast( event )
    local caster = event.caster
    local player = caster:GetPlayerOwner()
    local pID = caster:GetPlayerOwnerID()
    local ability = event.ability

    if ability.recast and caster:GetModifierStackCount("modifier_rage_stack", rage_ability) < event.RageRequirement then
        caster:Stop()
        EmitSoundOnClient("General.CastFail_InvalidTarget_Hero", player)

        Notifications:ClearBottom(pID)
        Notifications:Bottom(pID, {text="error_not_enough_rage", duration=2, style={color="#E62020"}, continue=false})
    end
end