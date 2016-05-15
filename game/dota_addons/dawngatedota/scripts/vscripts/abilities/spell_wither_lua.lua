function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	local spd = 45

	local pid = ParticleManager:CreateParticle("particles/spell_wither/wither_projectile_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pos = caster:GetAbsOrigin() + Vector(0, 0, 100)

	Timers:CreateTimer(function()
		local fv = -(pos - (target:GetAbsOrigin() + Vector(0, 0, 100))):Normalized()
		pos = pos + spd * fv
		ParticleManager:SetParticleControl(pid, 0, pos)
		ParticleManager:SetParticleControlForward(pid, 9, fv)
		if (pos - target:GetAbsOrigin()):Length2D() <= 120 then
			ParticleManager:DestroyParticle(pid, false)
			ability:ApplyDataDrivenModifier(caster, target, "modifier_withered", {})
			return
		end
		return 1 / 30
	end)
end