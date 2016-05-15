dofile("deal_damage")

function create_riptide( event )
	local caster = event.caster
	local damage_dealt = event.Damage
	local power_ratio = event.PowerRatio
	local riptide = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
    riptide:AddNewModifier(caster, nil, "modifier_invulnerable", {})
    local origin = caster:GetAbsOrigin()
	local unit_velocity = -(caster:GetAbsOrigin() - event.target_points[1]):Normalized()
    unit_velocity.z = 0
	local damage_dealt_to = { length = 0 }
	riptide:SetHullRadius(0)
    local riptide_z_offset = 0
	Timers:CreateTimer(function()
			if riptide:IsNull() then return nil end
			riptide:SetAbsOrigin(riptide:GetAbsOrigin() + unit_velocity * 37)
            riptide:SetAbsOrigin(Vector(riptide:GetAbsOrigin().x, riptide:GetAbsOrigin().y, GetGroundPosition(riptide:GetAbsOrigin(), riptide).z - riptide_z_offset))
			local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), riptide:GetAbsOrigin(), nil, 200, 
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
					knockback_unit(nearby, caster:GetAbsOrigin(), event.KnockupDuration, 0, 250)
					deal_damage(caster, nearby, damage_dealt, power_ratio, 1, caster:GetAbilityByIndex(3), false, false, true)
				end
			end
			return 1 / 30
		end
	)
	Timers:CreateTimer(1, function()
			if not riptide:IsNull() then riptide:Destroy() end
		end
	)
    local ticks = 0
    Timers:CreateTimer(function()
        riptide_z_offset = riptide_z_offset + 2.1
        ticks = ticks + 1
        if ticks > 60 then
            return nil
        end
        return 1 / 30
    end)
    Timers:CreateTimer(function()
        ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_riptide_foam.vpcf", PATTACH_ABSORIGIN_FOLLOW, riptide)
        ParticleManager:CreateParticle("particles/units/heroes/hero_siren/naga_siren_riptide_ring.vpcf", PATTACH_ABSORIGIN_FOLLOW, riptide)
        return 1 / 30
    end)
end