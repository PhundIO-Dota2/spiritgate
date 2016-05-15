function toggle(event)
    local caster = event.caster
    local ability = event.ability
    
    local ability_reaver = caster:FindAbilityByName("ability_ancient_babysitter_access_memory_reaver")
    local ability_sentinel = caster:FindAbilityByName("ability_ancient_babysitter_access_memory_sentinel")
    
    local highest_level = ability_reaver:GetLevel()
    if ability_sentinel:GetLevel() > highest_level  then highest_level = ability_sentinel:GetLevel() end
    
    ability_reaver:SetLevel(highest_level)
    ability_sentinel:SetLevel(highest_level)

    if caster:HasModifier("modifier_reconfigure_melee") then
        caster:RemoveModifierByName("modifier_reconfigure_melee")
        caster:SwapAbilities("ability_ancient_babysitter_access_memory_reaver", "ability_ancient_babysitter_access_memory_sentinel", false, true)
        caster:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
        caster:SetOriginalModel("models/heroes/faris/faris.vmdl")
        caster:SetModel("models/heroes/faris/faris.vmdl")
        EmitSoundOn("Hero_AncientBabysitter.AbilityReconfigureRanged", caster)
        --if ability.ranged_part ~= nil then
        --    ParticleManager:DestroyParticle(ability.ranged_part, false)
        --end
        --ability.ranged_part = ParticleManager:CreateParticle("particles/faris_reconfigure/reconfigure_melee_base.vpcf", PATTACH_POINT_FOLLOW, caster)
        --ParticleManager:SetParticleControlEnt(ability.ranged_part, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
    else 
        ability:ApplyDataDrivenModifier(caster, caster, "modifier_reconfigure_melee", { })	
        caster:SwapAbilities("ability_ancient_babysitter_access_memory_reaver", "ability_ancient_babysitter_access_memory_sentinel", true, false)
        caster:SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
        caster:SetOriginalModel("models/heroes/faris/farism.vmdl")
        caster:SetModel("models/heroes/faris/farism.vmdl")
        EmitSoundOn("Hero_AncientBabysitter.AbilityReconfigureMelee", caster)
        --if ability.melee_part ~= nil then
        --    ParticleManager:DestroyParticle(ability.melee_part, false)
        --end
        --ability.melee_part = ParticleManager:CreateParticle("particles/faris_reconfigure/reconfigure_ranged_base.vpcf", PATTACH_POINT_FOLLOW, caster)
        --ParticleManager:SetParticleControlEnt(ability.melee_part, 0, caster, PATTACH_POINT_FOLLOW, "attach_attack1", caster:GetAbsOrigin(), true)
    end
end

function on_attack_landed(event)
    dofile("deal_damage")
    local caster = event.caster
    local target = event.target
    if caster:HasModifier("modifier_reconfigure_melee") then
        local damage = event.MeleeDamage
        local health_damage = (target:GetMaxHealth() - target:GetHealth()) * (event.MeleeHealthPercent / 100.0 + event.MeleeHealthPercentPowerRatio * find_stat(caster, "power") / 100)
        health_damage = math.min(event.MaxDamageAgainstNonShapers - event.MeleeDamage, health_damage)
        deal_damage(caster, target, damage + health_damage, 0, 2, nil, false, false, false)
    else
        local damage = event.RangedDamage
        local health_damage = target:GetHealth() * (event.RangedHealthPercent / 100.0 + event.RangedHealthPercentPowerRatio * find_stat(caster, "power") / 100)
        health_damage = math.min(event.MaxDamageAgainstNonShapers - event.RangedDamage, health_damage)
        deal_damage(caster, target, damage + health_damage, 0, 2, nil, false, false, false)
    end
end