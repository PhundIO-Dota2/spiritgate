function toggle(event)
	local caster = event.caster
	local ability = event.ability
	local toggle_ability = caster:GetAbilityByIndex(10)

	local unleash_ability_1 = caster:GetAbilityByIndex(2)
	local unleash_ability_2 = caster:GetAbilityByIndex(11)

	toggle_ability:SetLevel(ability:GetLevel())
	unleash_ability_2:SetLevel(unleash_ability_1:GetLevel())

	caster:SwapAbilities(ability:GetAbilityName(), toggle_ability:GetAbilityName(), false, true)
	caster:SwapAbilities(unleash_ability_1:GetAbilityName(), unleash_ability_2:GetAbilityName(), false, true)
	
	toggle_ability:StartCooldown(get_ability_cooldown(caster, toggle_ability))
end