function AttackLanded(event)
	local caster = event.caster
	local target = event.target
	dofile("deal_damage")
	deal_damage(caster, target, event.BonusMagicalAttackDamage, event.BonusMagicalAttackDamagePowerRatio, 2, nil, false, false, false, 0)
	if target:IsHero() and not caster:HasModifier("modifier_loremaster_burden_slow_cooldown") then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_loremaster_burden_slow_cooldown", {})
		event.ability:ApplyDataDrivenModifier(caster, target, "modifier_loremaster_burden_slow", {})
		target:SetModifierStackCount("modifier_loremaster_burden_slow", caster, event.Slow)
	end
end