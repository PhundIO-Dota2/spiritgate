function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target

	Timers:CreateTimer(function()
		local new_pos = (caster:GetAbsOrigin() * 4 + target:GetAbsOrigin()) / 5
		if GetGroundPosition(new_pos, caster) ~= new_pos then
			return
		end
		caster:SetAbsOrigin(new_pos)
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
		if math_distance(caster, target) < caster:GetAttackRange() then
			if not caster:HasModifier("modifier_revolt_bold") then
				deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, false)
			else
				deal_damage(caster, target, event.BoldenedDamage, event.BoldenedDamagePowerRatio, 1, nil, false, false, false)
			end
			local pid = ParticleManager:CreateParticle("particles/basko_revolt/revolt_base.vpcf", PATTACH_CUSTOMORIGIN, target)
			ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin() + Vector(0, 0, 100))
			return
		end
		return 1 / 30
	end)
end