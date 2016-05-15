function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]

	local pid = ParticleManager:CreateParticle("particles/units/heroes/hero_phoenix/phoenix_fire_spirits_launch_bird.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 3, caster:GetAbsOrigin() + Vector(0, 0, 100))
	local pos = caster:GetAbsOrigin()

	local fv = (target - caster:GetAbsOrigin()):Normalized()

	local spd = 30
	local distance = 0

	local pierced_enemies = {}

	local pride_shaper = caster:FindAbilityByName("ability_pride_shaper")

	function release_explosion(position)
		local expl_hits = GetEnemiesInRadiusOfPoint(position, caster:GetTeamNumber(), event.ExplosionRadius, false)
		local pid_expl = ParticleManager:CreateParticle("particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf", PATTACH_CUSTOMORIGIN, nil)
		ParticleManager:SetParticleControl(pid_expl, 0, position)
		for _, expl_hit in pairs(expl_hits) do
			deal_damage(caster, expl_hit, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, true)
			pride_shaper:ApplyDataDrivenModifier(caster, expl_hit, "modifier_pride_shaper_pyre", {})
			expl_hit:SetModifierStackCount("modifier_pride_shaper_pyre", caster, expl_hit:GetModifierStackCount("modifier_pride_shaper_pyre", caster) + 1)
			event.ability:ApplyDataDrivenModifier(caster, expl_hit, "modifier_pyrebug_fireball_ministun", {}) 
		end
	end

	Timers:CreateTimer(function()
		distance = distance + spd
		pos = pos + fv * spd
		ParticleManager:SetParticleControl(pid, 3, pos + Vector(0, 0, 100))

		local hits = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 50, false)
		for _, hit in pairs(hits) do
			if not tableContains(pierced_enemies, hit) then
				pierced_enemies[#pierced_enemies + 1] = hit
				release_explosion(hit:GetAbsOrigin())
			end
		end

		if distance > event.Distance then
			release_explosion(pos)
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		return 1 /  30
	end)
end