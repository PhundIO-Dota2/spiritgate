function cast(event)
	local caster = event.caster
	local target = event.target_points[1]
	
	dofile("deal_damage")

	local unit = CreateUnitByName("npc_winters_bride_avalanche", target, false, nil, nil, DOTA_TEAM_NEUTRALS)
	unit:SetHullRadius(event.StunRadius)
	caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, unit, "modifier_dummy_unit_collide", {})

	local stuns = GetUnitsInRadiusOfPoint(target, caster:GetTeamNumber(), event.StunRadius)
	for _, guy in pairs(stuns) do
		if guy:GetTeamNumber() == caster:GetTeamNumber() then
			FindClearSpaceForUnit(guy, guy:GetAbsOrigin(), false)
		else
			event.ability:ApplyDataDrivenModifier(caster, guy, "modifier_avalanche_winters_bride_stun", {Duration = 1.75})
			deal_damage(caster, guy, event.Damage, event.DamagePowerRatio, 2, event.ability, false, false, false)
			apply_frost(event, caster, guy)
		end
	end
	local pid = ParticleManager:CreateParticle("particles/sakari_avalanche/avalanche_ability_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, unit:GetAbsOrigin())

	Timers:CreateTimer(1.75, function()
		local burst_hits = GetEnemiesInRadiusOfPoint(target, caster:GetTeamNumber(), event.BurstRadius)
		for _, guy in pairs(burst_hits) do
			deal_damage(caster, guy, event.BurstDamage, event.BurstDamagePowerRatio, 2, event.ability, false, false, false)
			apply_frost(event, caster, guy)
		end
		unit:Kill(nil, nil)
	end)
end
function apply_frost(event, caster, guy)
	local ice_lance = caster:FindAbilityByName("ability_winters_bride_ice_lance")
	disable({
		caster = caster,
		target = guy,
		Duration = 3,
		DisableModifier = "modifier_ice_lance_slow",
		ability = ice_lance,
	})
	disable({
		caster = caster,
		target = guy,
		Duration = 3,
		DisableModifier = "modifier_ice_lance_slow_stack",
		ability = ice_lance,
	})
	guy:SetModifierStackCount("modifier_ice_lance_slow_stack", caster, guy:GetModifierStackCount("modifier_ice_lance_slow_stack", caster) + 1)
end