function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target_point = event.target_points[1]
	local ability = event.ability

	local enemies = GetEnemiesInCone(caster, event.Radius, (target_point - caster:GetAbsOrigin()):Normalized(), 1.7)

	local fv = (target_point - caster:GetAbsOrigin()):Normalized()

	local pid = ParticleManager:CreateParticle("particles/kahgen_heat_wave/heat_wave_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(pid, 1, fv * event.Radius)

	for k, v in ipairs(enemies) do
		local stacks = v:GetModifierStackCount("modifier_spirit_sand", caster)
		v:RemoveModifierByName("modifier_spirit_sand")

		deal_damage(caster, 
			v, 
				event.Damage + find_stat(caster, "power") * event.PowerRatio + 
				event.StackDamage * stacks + find_stat(caster, "power") * stacks * event.StackDamagePowerRatio, 
			0, 
			1, 
			ability, 
			false, 
			false, 
			true
		)
		disable({
			caster = caster,
			target = v,
			ability = ability,
			DisableModifier = "modifier_desert_raider_heat_wave_stun",	
			Duration = event.StunDuration + stacks * event.StackStunDuration
		})
	end
end