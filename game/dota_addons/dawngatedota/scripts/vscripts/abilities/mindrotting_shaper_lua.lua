function on_attack_landed(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target
	local ability = event.ability

	if not target:HasModifier("modifier_mindrotting_shaper_cooldown") then
		ability:ApplyDataDrivenModifier(caster, target, "modifier_mindrotting_shaper_cooldown", {})
		disable({
			caster = caster,
			target = target,
			ability = ability,
			Duration = 0.75,
			DisableModifier = "modifier_mindrotting_shaper_silence",
		})
		mult = 1
		if not target:IsHero() then mult = 2 end --Double damage against non-shapers
		deal_damage(caster, target, (12 + 3 * caster:GetLevel()) * mult, 0.5 * mult, 2, ability, false, false, false)
	end
end