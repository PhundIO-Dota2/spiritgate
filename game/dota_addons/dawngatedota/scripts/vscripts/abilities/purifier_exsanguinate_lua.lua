function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	dofile("deal_damage")

	ability.pid = ParticleManager:CreateParticle("particles/viyanna_exsanguinate/exsanguinate_base.vpcf", PATTACH_CUSTOMORIGIN, nil)

	ability:ApplyDataDrivenModifier(caster, target, "modifier_purifier_exsanguinate_supressed", {})
	ability.timer = Timers:CreateTimer(function()
		deal_damage(caster, target, event.Damage / 30 / 2, event.DamagePowerRatio / 30 / 2, 2, ability, true, false, false)
		deal_damage_heal(caster, caster, event.Heal / 30 / 2, 0, event.HealHealthRatio / 30 / 2)
		target:SetAbsOrigin(GetGroundPosition(target:GetAbsOrigin(), target) + Vector(0, 0, 250))
		ParticleManager:SetParticleControl(ability.pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(ability.pid, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
		return 1 / 30
	end)
end

function end_cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	Timers:RemoveTimer(ability.timer)
	ParticleManager:DestroyParticle(ability.pid, false)

	target:RemoveModifierByName("modifier_purifier_exsanguinate_supressed")
	target:SetAbsOrigin(GetGroundPosition(target:GetAbsOrigin(), target))
end