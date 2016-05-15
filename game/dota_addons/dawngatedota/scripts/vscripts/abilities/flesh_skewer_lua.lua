function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local target = event.target_points[1]

	local spd = 28

	local fv = -(caster:GetAbsOrigin() - target):Normalized()

	local skewer_pos = caster:GetAbsOrigin()
	local skewer_pid = ParticleManager:CreateParticle("particles/vex_skewer/skewer_ability_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local skewer_distance = 0

	local hit_enemies = {}

	Timers:CreateTimer(function()
		skewer_distance = skewer_distance + spd
		skewer_pos = skewer_pos + fv * spd
		ParticleManager:SetParticleControl(skewer_pid, 0, skewer_pos)
		if skewer_distance > event.Distance then
			ParticleManager:DestroyParticle(skewer_pid, false)
			return
		end
		local enemies = GetEnemiesInRadiusOfPoint(skewer_pos, caster:GetTeamNumber(), 80)
		for _, enemy in pairs(enemies) do
			if not tableContains(hit_enemies, enemy) then
				hit_enemies[#hit_enemies + 1] = enemy
				event.ability:ApplyDataDrivenModifier(caster, enemy, "modifier_flesh_skewer_armour_reduction", {})
				deal_damage(caster, enemy, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
			end
		end
		return 1 / 30
	end)
end