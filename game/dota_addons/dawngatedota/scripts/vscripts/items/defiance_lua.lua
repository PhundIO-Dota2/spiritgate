function tick(event)
    local caster = event.caster
    local item = event.ability
    if caster:GetHealth() < caster:GetMaxHealth() / 4 then
        item:ApplyDataDrivenModifier(caster, caster, "item_defiance_cdr", { })
    else
        caster:RemoveModifierByName("item_defiance_cdr")
    end
end