if ability_elegant_dancer_gale == nil then
    ability_elegant_dancer_gale = class({})
end

function ability_elegant_dancer_gale:OnSpellStart()
    dofile("deal_damage")
    local target = self:GetCursorPosition()
    local origin = self:GetCaster():GetAbsOrigin()
    local fv = (target - origin):Normalized()
    local pid = ParticleManager:CreateParticle("particles/ashabel_gale/gale_projectile_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
    local warning_pid = ParticleManager:CreateParticle("particles/radius_indicator/radius_indicator.vpcf", PATTACH_CUSTOMORIGIN, nil)
    local pos = origin
    ParticleManager:SetParticleControl(warning_pid, 0, GetGroundPosition(target + Vector(0, 0, 200), nil) + Vector(0, 0, 1))
    ParticleManager:SetParticleControl(warning_pid, 1, Vector(100, 3, 0))
    
    local damage_mult = 1
    if self:GetCaster():GetAbilityByIndex(1):GetAbilityName() ~= "ability_elegant_dancer_stance_dance" then
        damage_mult = 1.25
    end
    damage_mult = damage_mult * (1 + self:GetCaster():GetAbilityByIndex(1):GetSpecialValueFor("%passive_gale_increased_damage") / 100)
        
    Timers:CreateTimer(function()
        ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, math.min(100, math_distance(pos, target) / 2)))
        pos = pos + fv * 36
        if math_distance(pos, target) < 30 then
            ParticleManager:DestroyParticle(pid, false)
            local targets = GetEnemiesInRadiusOfPoint(pos, self:GetCaster():GetTeamNumber(), self:GetSpecialValueFor("radius"))
            for _, target_enemy in pairs(targets) do
                deal_damage(self:GetCaster(), target_enemy, self:GetSpecialValueFor("damage") * damage_mult, self:GetSpecialValueFor("damage_power_ratio") * damage_mult, 2, self, false, false, true)
            end
            local hit_pid = ParticleManager:CreateParticle("particles/ashabel_gale/gale_hit.vpcf", PATTACH_CUSTOMORIGIN, nil)
            ParticleManager:DestroyParticle(warning_pid, true)
            ParticleManager:SetParticleControl(hit_pid, 0, pos)
            return
        end
        return 1 / 30
    end)
end

function ability_elegant_dancer_gale:GetCastRange( vLocation, hTarget )
    local caster = self:GetCaster()
    local base_range = self:GetSpecialValueFor("cast_range")
    if caster.GetAbilityByIndex == nil then
        return base_range
    end
    if caster:GetAbilityByIndex(1):GetAbilityName() == "ability_elegant_dancer_stance_dance" then
        return base_range * 1.2
    else
        return base_range * 0.8
    end
end