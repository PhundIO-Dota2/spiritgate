function take_damage(event)
	local caster = event.caster
    local attacker = event.attacker
    if (not attacker:IsHero()) or event.Damage < 1 then
        return
    end
	local ability = caster:FindAbilityByName("ability_universal_ability")
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_fervor", { Duration = 10 })	
	local stacks = caster:GetModifierStackCount("modifier_fervor", caster)
	if stacks ~= 0 then
		caster:SetModifierStackCount("modifier_fervor", ability, math.min(
				count_items(caster, "item_conviction") + count_items(caster, "item_faith") + count_items(caster, "item_retribution"),
				stacks + 1
			)
		)
	else
		caster:SetModifierStackCount("modifier_fervor", ability, 1)
	end
end