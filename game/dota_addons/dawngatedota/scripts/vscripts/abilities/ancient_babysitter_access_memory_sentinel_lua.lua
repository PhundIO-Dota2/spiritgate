function on_spell_start(event)
	dofile("deal_damage")
	local caster = event.caster
	local point = event.target_points[1]
	local volleys = event.Volleys
	local fv = -(caster:GetAbsOrigin() - point):Normalized()

	local root_unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	root_unit:SetForwardVector(fv)
	root_unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local rootPartID = ParticleManager:CreateParticle("particles/faris_access_memory/sentinel_ability_base.vpcf", PATTACH_ABSORIGIN, root_unit)
	ParticleManager:SetParticleControlOrientation(rootPartID, 0, fv, root_unit:GetRightVector(), root_unit:GetUpVector())
	Timers:CreateTimer(event.Duration / event.Volleys, function()
		local enemies = GetEnemiesInCone(root_unit, event.Range - 100, fv, 0.76)
		for k, enemy in ipairs(enemies) do
			deal_damage(caster, enemy, event.Damage / event.Volleys, event.PowerRatio / event.Volleys, 2, event.ability, false, false, true)
		end

		volleys = volleys - 1
		if volleys == 0 then return nil end
		return event.Duration / event.Volleys
	end)
	Timers:CreateTimer(4, function()
		root_unit:Destroy()
		return nil
	end)
end