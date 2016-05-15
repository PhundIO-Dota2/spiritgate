function precast(event)
	local caster = event.caster
    local player = caster:GetPlayerOwner()
    local pID = caster:GetPlayerOwnerID()

	if not caster:HasModifier("modifier_ice_shard") then
		caster:Stop()

        Notifications:ClearBottom(pID)
        Notifications:Bottom(pID, {text="error_not_enough_ice_shards", duration=2, style={color="#E62020"}, continue=false})
	end
end

function cast(event)
	local caster = event.caster
	local target = event.target_points[1]

	if not caster:HasModifier("modifier_ice_shard") then
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return
	end

	caster:SetModifierStackCount("modifier_ice_shard", caster, caster:GetModifierStackCount("modifier_ice_shard", caster) - 1)
	if caster:GetModifierStackCount("modifier_ice_shard", caster) == 0 then
		caster:RemoveModifierByName("modifier_ice_shard")
	end

	local unit = CreateUnitByName("npc_winters_bride_iceberg", target, false, nil, nil, DOTA_TEAM_NEUTRALS)
	unit:SetHullRadius(100)
	caster:FindAbilityByName("ability_universal_ability"):ApplyDataDrivenModifier(caster, unit, "modifier_dummy_unit_collide", {})

	local knockbacks = GetUnitsInRadiusOfPoint(target, caster:GetTeamNumber(), 100)
	for _, guy in pairs(knockbacks) do
		if guy:GetUnitName() ~= "npc_winters_bride_iceberg" then
			FindClearSpaceForUnit(guy, guy:GetAbsOrigin(), false)
		end
	end
	local old_pos = unit:GetAbsOrigin()
	FindClearSpaceForUnit(unit, unit:GetAbsOrigin(), false)
	unit:SetAbsOrigin((unit:GetAbsOrigin() + old_pos) / 2)

	local pid = ParticleManager:CreateParticle("particles/sakari_iceberg/iceberg_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, unit:GetAbsOrigin())

	Timers:CreateTimer(4, function()
		unit:Kill(nil, nil)
	end)
end

function tick(event)
	local caster = event.caster
	local ability = event.ability
	if ability.iceshard_ticker == nil then
		ability.iceshard_ticker = Timers:CreateTimer(get_cooldown_reduction_percentage(caster) * 10, function()
			ability:ApplyDataDrivenModifier(caster ,caster, "modifier_ice_shard", {})
			caster:SetModifierStackCount("modifier_ice_shard", caster, math.min(tonumber(ability:GetSpecialValueFor("ice_shard_storage")), caster:GetModifierStackCount("modifier_ice_shard", caster) + 1))
			ability.iceshard_ticker = nil
		end)
	end

	local speed = ability:GetSpecialValueFor("frost_replenish_speed")
	local time_accounted_for = 4 - speed
	local interval = time_accounted_for * 0.4

	if ability.frost_ticker == nil then
		ability.frost_ticker = Timers:CreateTimer(interval, function()
			local frost_ability = caster:FindAbilityByName("ability_frost_shaper")
			if not caster:HasModifier("recent_cast_modifier") then
				frost_ability:ApplyDataDrivenModifier(caster, caster, "modifier_frost", {})
				caster:SetModifierStackCount("modifier_frost", caster, math.min(caster:GetModifierStackCount("modifier_frost", caster) + 1, 10))
			end
			ability.frost_ticker = nil
		end)
	end
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_iceberg_power", {})
	caster:SetModifierStackCount("modifier_iceberg_power", caster, ability:GetLevel() + 1)
end