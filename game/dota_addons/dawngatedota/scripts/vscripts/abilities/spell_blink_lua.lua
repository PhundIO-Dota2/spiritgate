function item_blink_datadriven_on_spell_start(keys)
    ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, keys.caster)
    keys.caster:EmitSound("DOTA_Item.BlinkDagger.Activate")
    
    local origin_point = keys.caster:GetAbsOrigin()
    local target_point = keys.target_points[1]
    local difference_vector = target_point - origin_point
    
    if difference_vector:Length2D() > keys.MaxBlinkRange then  --Clamp the target point to the BlinkRangeClamp range in the same direction.
        target_point = origin_point + (target_point - origin_point):Normalized() * keys.MaxBlinkRange
    end
    
    keys.caster:SetAbsOrigin(target_point)
    FindClearSpaceForUnit(keys.caster, target_point, false)
    
    ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, keys.caster)
end