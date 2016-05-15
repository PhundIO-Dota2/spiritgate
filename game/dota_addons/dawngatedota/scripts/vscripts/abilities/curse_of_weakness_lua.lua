dofile("deal_damage")

function on_attack(event)
    local caster = event.caster
    local target = event.target
    local ability = event.ability
    if target:HasModifier("modifier_curse_of_weakness_primary") then
        target:RemoveModifierByName("modifier_curse_of_weakness_primary")
        deal_damage(caster, target, event.Damage, event.PowerRatio, 2, ability, false, false, false)
    end
end