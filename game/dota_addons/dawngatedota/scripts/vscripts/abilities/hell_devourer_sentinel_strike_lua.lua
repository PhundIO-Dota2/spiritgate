function attack_landed(event)
    dofile("deal_damage") --I have no idea why this needs to be here, but it does. 
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	if target:IsHero() then
		local old_cd = ability:GetCooldownTimeRemaining()
		local new_cd = old_cd - 2
		ability:EndCooldown()
		if new_cd > 0 then
			ability:StartCooldown(new_cd)
		end
	end
	if caster:HasModifier("modifier_sentinel_strike") then
		local cleave_targets = GetEnemiesInCone(caster, event.Radius, caster:GetForwardVector(), 2.3)--, true)
		for k, v in ipairs(cleave_targets) do
			deal_damage(caster, v, event.Damage, event.PowerRatio, 2, ability, false, false, true)
		end
		caster:RemoveModifierByName("modifier_sentinel_strike")
	end
end