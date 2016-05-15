function on_spell_start(event)
	dofile("deal_damage")
	local caster = event.caster
	local point = event.target_points[1]
	local fv = -(caster:GetAbsOrigin() - point):Normalized()

	local root_unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	root_unit:SetForwardVector(fv)
	root_unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local rootPartID = ParticleManager:CreateParticle("particles/faris_access_memory/reaver_ability_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, root_unit)
	ParticleManager:SetParticleControlOrientation(rootPartID, 0, fv, root_unit:GetRightVector(), root_unit:GetUpVector())

	local hit_enemies = {}
	Timers:CreateTimer(function()
		if root_unit:IsNull() then return nil end
		root_unit:SetAbsOrigin(root_unit:GetAbsOrigin() + fv * 30)
		local enemies = GetEnemiesInRadius(root_unit, 130)
		for k, enemy in ipairs(enemies) do
			if not tableContains(hit_enemies, enemy) then
				if enemy:IsHero() then
					ParticleManager:DestroyParticle(rootPartID, true)
					root_unit:Destroy()
					deal_damage(caster, enemy, event.ShaperDamage, event.ShaperDamagePowerRatio, 2, event.ability, false, false, false)
				else
					deal_damage(caster, enemy, event.CreepDamage, event.CreepDamagePowerRatio, 2, event.ability, false, false, true)
				end
				tableAdd(hit_enemies, enemy)
			end
		end
		return 1 / 30
	end)
	Timers:CreateTimer(1, function()
		if root_unit:IsNull() then return nil end
		root_unit:Destroy()
		return nil
	end)
end