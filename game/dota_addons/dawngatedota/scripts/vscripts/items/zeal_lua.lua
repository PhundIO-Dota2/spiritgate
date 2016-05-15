function ZealAttackLanded(event)
	local caster = event.caster
	local target = event.target
	local reduction = 0.25
	if event.target:IsHero() then
		reduction = reduction * 2
	end
	for i=0, 3 do
		local ability = caster:GetAbilityByIndex(i)
		local new_cooldown = ability:GetCooldownTimeRemaining() - reduction
		ability:EndCooldown()
		if new_cooldown > 0 then
			ability:StartCooldown(new_cooldown)
		end
	end
end