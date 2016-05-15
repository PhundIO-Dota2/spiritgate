function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local point = event.target_points[1]
	local radius = event.Radius

	local unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	unit:SetHullRadius(0)
	local fv = -(caster:GetAbsOrigin() - point):Normalized()
	unit:SetAbsOrigin(unit:GetAbsOrigin() + fv * 300)
	local pid = ParticleManager:CreateParticle("particles/guardian/guardian_snare_bubble_form.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, unit)

	Timers:CreateTimer(2, function()
		ParticleManager:DestroyParticle(pid, false)
		pid = ParticleManager:CreateParticle("particles/guardian/guardian_snareball_base.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, unit)
	end)
	Timers:CreateTimer(2, function()
		if unit:IsNull() then return end
		unit:SetAbsOrigin(unit:GetAbsOrigin() + fv * 6)
		local targets = GetEnemiesInRadius(unit, radius)
		if #targets > 0 then
			local target = targets[1]
			knockback_unit(target, target:GetAbsOrigin(), event.Duration, 0, 500, true)
			unit:Destroy()
			ParticleManager:DestroyParticle(pid, false)
			return nil
		end
		return 1 / 30
	end)
	Timers:CreateTimer(9, function()
		if not unit:IsNull() then unit:Destroy() end
		ParticleManager:DestroyParticle(pid, false)
	end)
end