function regenerate_spirit(event) 
    local time_taken = 5.0
	local haste = find_stat(event.caster, "haste")
    local time_taken_reduced = (100 * time_taken) / (100 + 0.4 * haste)
    event.caster:GiveMana((event.caster:GetMaxMana() * 0.06) / time_taken_reduced / 10.0)
    -- 6% of total / 5 (over 5 seconds, faster by haste) / 10 (ticks 10 times a second)
    local ability = event.caster:FindAbilityByName("ability_momentum_shaper")
    ability:ApplyDataDrivenModifier(event.caster, event.caster, "modifier_momentum_mana_scale", { })
    event.caster:SetModifierStackCount("modifier_momentum_mana_scale", event.caster, event.caster:GetLevel())
end