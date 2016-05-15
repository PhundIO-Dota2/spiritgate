function fire(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target
	local damage = event.Damage
	local damage_power_ratio = event.DamagePowerRatio

	local pid = ParticleManager:CreateParticle("particles/binding/binding_attack_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	local pos = caster:GetAbsOrigin() + Vector(0, 0, 200)

	Timers:CreateTimer(function()
		ParticleManager:SetParticleControl(pid, 0, pos)
		local fv = (target:GetAbsOrigin() + Vector(0, 0, 75) - pos):Normalized() * 30
		pos = pos + fv
		if math_distance(target:GetAbsOrigin(), pos) < 20 then
			deal_damage(caster, target, damage, damage_power_ratio, 1, event.ability, false, false, false)
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		return 1 / 30
	end)
end