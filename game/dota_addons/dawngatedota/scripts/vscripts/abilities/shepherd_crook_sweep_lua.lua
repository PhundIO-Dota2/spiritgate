function cast(event)
	local caster = event.caster
	local pid = ParticleManager:CreateParticle("particles/kel_crook_sweep/crook_sweep_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))

	dofile("deal_damage")

	local hits = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)
	for _, v in pairs(hits) do
		knockback_unit(v, v:GetAbsOrigin(), event.KnockupDuration, 0, 250, true)
		deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
	end
end