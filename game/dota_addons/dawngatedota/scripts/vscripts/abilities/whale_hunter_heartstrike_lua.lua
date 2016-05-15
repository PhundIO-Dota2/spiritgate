function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	local knife_toss_ability = caster:FindAbilityByName("ability_whale_hunter_knife_toss")

	while target:HasModifier("modifier_whale_hunter_knife_stuck") do
		target:RemoveModifierByName("modifier_whale_hunter_knife_stuck")
		caster:SetModifierStackCount("modifier_whale_hunter_knives", caster, math.min(2, (caster:GetModifierStackCount("modifier_whale_hunter_knives", caster) + 1)))
	end

	local pid = ParticleManager:CreateParticle("particles/viridian_heartstrike/heartstrike_blood.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(pid, 1, target:GetAbsOrigin() - ((target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()) * 50 + Vector(0, 0, 50))

	dofile("deal_damage")

	local rage = caster:GetModifierStackCount("modifier_rage_adrenaline_stack", caster)
	deal_damage(caster, target, ((event.MaxDamage - event.MinDamage) * rage / 100) + event.MinDamage, event.DamagePowerRatio, 1, ability, false, false, false)

	deal_damage_heal(caster, caster, ((3 - 0.72) * ((caster:GetLevel() - 1) / 19) + 0.72) * rage, 0, 0)
	caster:SetModifierStackCount("modifier_rage_adrenaline_stack", caster, 0)
end