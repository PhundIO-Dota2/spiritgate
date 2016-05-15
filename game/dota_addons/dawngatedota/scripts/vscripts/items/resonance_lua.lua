function OnResonanceAttackLanded(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target
	deal_damage(caster, target, 15, 0.10, 2, "RESONANCE", false, false, false)

	local targets = GetEnemiesInRadiusOfPoint(target:GetAbsOrigin(), caster:GetTeamNumber(), 400)

	for k, v in ipairs(targets) do
		if v == target then table.remove(targets, k) break end
	end

	if #targets > 0 then
		local pid = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf", PATTACH_CUSTOMORIGIN, caster)
		
		local found_unit = false
		for k, v in ipairs(targets) do
			if v:IsHero() then found_unit = v end
		end
		found_unit = targets[RandomInt(1, #targets)]
		ParticleManager:SetParticleControl(pid, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
		ParticleManager:SetParticleControl(pid, 0, found_unit:GetAbsOrigin() + Vector(0, 0, 100))
		deal_damage(caster, found_unit, GetBasicAttackDamage(caster) / 2, 0, 1, "RESONANCE", false, false, false)
	end
end