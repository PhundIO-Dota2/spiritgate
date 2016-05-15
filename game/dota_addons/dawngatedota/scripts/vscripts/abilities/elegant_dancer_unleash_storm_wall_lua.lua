function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local origin = event.caster:GetAbsOrigin()
	local targets = GetEnemiesInRadiusOfPoint(origin, caster:GetTeamNumber(), 300)

	ParticleManager:SetParticleControl(ParticleManager:CreateParticle("particles/ashabel_unleash/stormwall_base.vpcf", PATTACH_CUSTOMORIGIN, nil), 0, caster:GetAbsOrigin() + Vector(0, 0, 50))
	
	for _, target in pairs(targets) do
		knockback_unit(target, origin, 0.25, 175, 100, false)
		deal_damage(caster, target, event.Damage, event.PowerRatio, 2, event.ability, false, false, true)
	end
end