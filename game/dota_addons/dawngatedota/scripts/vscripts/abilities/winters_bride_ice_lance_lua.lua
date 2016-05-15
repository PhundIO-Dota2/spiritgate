function precast(event)
	local caster = event.caster
    local player = caster:GetPlayerOwner()
    local pID = caster:GetPlayerOwnerID()

	if not caster:HasModifier("modifier_frost") then
		caster:Stop()

        Notifications:ClearBottom(pID)
        Notifications:Bottom(pID, {text="error_not_enough_frost", duration=2, style={color="#E62020"}, continue=false})
	end
end

function cast(event)
	local caster = event.caster
	local target = event.target_points[1]

	local stacks = caster:GetModifierStackCount("modifier_frost", caster)
	if stacks >= 1 then
		stacks = stacks - 1
		caster:SetModifierStackCount("modifier_frost", caster, stacks)
		if stacks == 0 then
			caster:RemoveModifierByName("modifier_frost")
		end
	else
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return
	end

	local pos = caster:GetAbsOrigin()
	local fv = (target - caster:GetAbsOrigin()):Normalized()
	local spd = 30
	local distance = 0

	local pid = ParticleManager:CreateParticle("particles/frostivus_gameplay/drow_ice_trail.vpcf", PATTACH_CUSTOMORIGIN, nil)

	Timers:CreateTimer(function()
		pos = pos + fv * spd
		distance = distance + spd
		ParticleManager:SetParticleControl(pid, 3, pos + Vector(0, 0, 80))
		local enemies = GetEnemiesInRadiusOfPoint(pos, caster:GetTeamNumber(), 80)
		for _, enemy in ipairs(enemies) do
			dofile("deal_damage")
			caster:FindAbilityByName("ability_frost_shaper"):ApplyDataDrivenModifier(caster, caster, "modifier_black_ice", {})
			caster:SetModifierStackCount("modifier_black_ice", caster, math.min(5, caster:GetModifierStackCount("modifier_black_ice", caster) + 1))
			deal_damage(caster, enemy, event.Damage, event.PowerRatio, 2, event.ability, false, false, false)
			disable({
				caster = caster,
				target = enemy,
				Duration = 3,
				DisableModifier = "modifier_ice_lance_slow",
				ability = event.ability,
			})
			disable({
				caster = caster,
				target = enemy,
				Duration = 3,
				DisableModifier = "modifier_ice_lance_slow_stack",
				ability = event.ability,
			})
			enemy:SetModifierStackCount("modifier_ice_lance_slow_stack", caster, enemy:GetModifierStackCount("modifier_ice_lance_slow_stack", caster) + 1)
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		if distance > event.Range then
			ParticleManager:DestroyParticle(pid, false)
			return
		end
		return 1 / 30
	end)
end

function try_regen_frost(event)
	local caster = event.caster
	local ability = event.ability
	local frost_ability = caster:FindAbilityByName("ability_frost_shaper")
	if not caster:HasModifier("recent_cast_modifier") then
		frost_ability:ApplyDataDrivenModifier(caster, caster, "modifier_frost", {})
		caster:SetModifierStackCount("modifier_frost", caster, math.min(caster:GetModifierStackCount("modifier_frost", caster) + 1, 10))
	end
end