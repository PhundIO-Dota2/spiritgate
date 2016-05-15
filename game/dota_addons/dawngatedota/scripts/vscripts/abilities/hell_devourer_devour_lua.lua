function on_spell_start(event)
    dofile("deal_damage")
	local caster = event.caster
	local radius = event.Radius
	local point = event.target_points[1]

	local fv = -(caster:GetAbsOrigin() - point):Normalized()

	local devour_particle = ParticleManager:CreateParticle("particles/voluc_devour/devour_ability_base.vpcf", PATTACH_CUSTOMORIGIN, caster)
	ParticleManager:SetParticleControl(devour_particle, 0, caster:GetAbsOrigin() + Vector(0, 0, 160))
	ParticleManager:SetParticleControl(devour_particle, 1, caster:GetAbsOrigin() + fv * 1000 + Vector(0, 0, 160))

	local targets = GetEnemiesInCone(caster, radius, fv)--, 1, true)
	if #targets > 0 then
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_hell_devourer_vengeance", { })	
		event.ability:ApplyDataDrivenModifier(caster, caster, "modifier_hell_devourer_vengeance_hidden", { })	
		local stacks = caster:GetModifierStackCount("modifier_hell_devourer_vengeance", caster)
		for k,v in ipairs(targets) do
			--print(deal_damage)
			deal_damage(caster, v, event.Damage, event.PowerRatio, 2, event.ability, false, false, true)
			if v:IsHero() then
				stacks = stacks + event.ShaperStacks
			else
				stacks = stacks + event.OtherStacks
			end
            create_food(event, v)
		end
		stacks = math.min(4, stacks)
		caster:SetModifierStackCount("modifier_hell_devourer_vengeance", event.ability, stacks)
		caster:SetModifierStackCount("modifier_hell_devourer_vengeance_hidden", event.ability, stacks * event.HasteStackRate)
	end
end
function create_food(event, target)
    local caster = event.caster
	local proj = CreateUnitByName("npc_typhoon_riptide", target:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
    proj:AddNewModifier(caster, nil, "modifier_invulnerable", {})
    local origin = target:GetAbsOrigin()
	local unit_velocity = -(proj:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
    unit_velocity.z = 0
	local damage_dealt_to = { length = 0 }
	proj:SetHullRadius(0)
    local proj_z_offset = 0

    local mainPartID = ParticleManager:CreateParticle("particles/voluc_devour/devour_food.vpcf", PATTACH_CUSTOMORIGIN, proj)
	ParticleManager:SetParticleControl(mainPartID, 0, caster:GetAbsOrigin() + Vector(0, 0, 160))
	ParticleManager:SetParticleControl(mainPartID, 1, target:GetAbsOrigin() + Vector(0, 0, 160))

	Timers:CreateTimer(function()
			if proj:IsNull() or target:IsNull() then return nil end
            local origin = proj:GetAbsOrigin()
            local unit_velocity = -(proj:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()
			proj:SetAbsOrigin(proj:GetAbsOrigin() + unit_velocity * 20)
            proj:SetAbsOrigin(Vector(proj:GetAbsOrigin().x, proj:GetAbsOrigin().y, GetGroundPosition(proj:GetAbsOrigin(), proj).z - proj_z_offset))
			local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), proj:GetAbsOrigin(), nil, 10, 
				DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for i, nearby in ipairs(nearby_enemies) do
				if nearby == event.caster then
					ParticleManager:DestroyParticle(mainPartID, false)
                    proj:Destroy()
                end
			end
			return 1 / 30
		end
	)
	Timers:CreateTimer(0.2, function()
		ParticleManager:DestroyParticle(mainPartID, false)
	end)
	Timers:CreateTimer(10, function()
        if not proj:IsNull() then 
            proj:Destroy() 
            ParticleManager:DestroyParticle(mainPartID, false)
        end
    end)
    local ticks = 0
    Timers:CreateTimer(function()
        if proj:IsNull() then return nil end
        proj_z_offset = proj_z_offset + 6.1
        ticks = ticks + 1
		ParticleManager:SetParticleControl(mainPartID, 0, caster:GetAbsOrigin() + Vector(0, 0, 160))
        if ticks > 17 then
            return nil
        end
        return 1 / 30
    end)
end