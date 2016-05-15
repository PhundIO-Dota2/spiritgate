function create_curse_of_weakness( event )
    dofile("deal_damage")

	local caster = event.caster
	local damage_dealt = event.Damage
	local power_ratio = event.PowerRatio
    local ability = event.ability
    local target = event.target
	local proj = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
    proj:AddNewModifier(caster, nil, "modifier_invulnerable", {})
    local origin = caster:GetAbsOrigin()
	local unit_velocity = -(caster:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
    unit_velocity.z = 0
	local damage_dealt_to = { length = 0 }
	proj:SetHullRadius(0)
    local proj_z_offset = 0
	Timers:CreateTimer(function()
			if proj:IsNull() then return nil end
            if not target:IsAlive() then
                proj:EmitSound("Hero_WarlockKnight.CurseOfWeaknessHit")
                proj:Destroy()
                return
            end
            local origin = proj:GetAbsOrigin()
            local unit_velocity = -(proj:GetAbsOrigin() - target:GetAbsOrigin()):Normalized()
			proj:SetAbsOrigin(proj:GetAbsOrigin() + unit_velocity * 25)
            proj:SetAbsOrigin(Vector(proj:GetAbsOrigin().x, proj:GetAbsOrigin().y, GetGroundPosition(proj:GetAbsOrigin(), proj).z - proj_z_offset))
			local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), proj:GetAbsOrigin(), nil, 25, 
				DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
			for i, nearby in ipairs(nearby_enemies) do
				local pass = true

				for j=0, damage_dealt_to.length do
					if damage_dealt_to[j] == nearby then
						pass = false
						break
					end
				end
				if pass then
					damage_dealt_to[damage_dealt_to.length] = nearby
					damage_dealt_to.length = damage_dealt_to.length + 1
					
					deal_damage(caster, nearby, damage_dealt, power_ratio, 1, caster:GetAbilityByIndex(3), false, false, true)
                    if nearby == event.target then
                        disable({
                            caster = event.caster,
                            target = nearby,
                            ability = event.ability,
                            Duration = event.DurationPrimary,
                            DisableModifier = "modifier_curse_of_weakness_primary"
                        })
                        --ability:ApplyDataDrivenModifier(caster, nearby, "modifier_curse_of_weakness_primary", { })
                        proj:EmitSound("Hero_WarlockKnight.CurseOfWeaknessHit")
                        proj:Destroy()
                    else
                        disable({
                            caster = event.caster,
                            target = nearby,
                            ability = event.ability,
                            Duration = event.DurationSecondary,
                            DisableModifier = "modifier_curse_of_weakness_secondary"
                        })
                        --ability:ApplyDataDrivenModifier(caster, nearby, "modifier_curse_of_weakness_secondary", { })
                    end
				end
			end
			return 1 / 30
		end
	)
    local mainPartID = ParticleManager:CreateParticle("particles/voluc_curse_of_weakness/curse_of_weakness_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, proj)
	Timers:CreateTimer(6, function()
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
        if ticks > 17 then
            return nil
        end
        return 1 / 30
    end)
    Timers:CreateTimer(function()
        if proj:IsNull() then return nil end
        proj:EmitSound("Hero_WarlockKnight.CurseOfWeaknessTick")
        return 1 / 30
    end)
end