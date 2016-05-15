function SetTarget(event) 
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local unit = ability.unit
	if ability.pid ~= nil then
		ParticleManager:DestroyParticle(ability.pid, false)
	end
	ability.target_unit:RemoveModifierByName("modifier_muse")
	ability.target_unit = target
	if target ~= caster then
		ability.pid = ParticleManager:CreateParticle("particles/zeri_muse/zeri_muse_buffring.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	end
end
function Spawn(event)
	local caster = event.caster
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, caster, "modifier_muse_passive_power", {})
	caster:SetModifierStackCount("modifier_muse_passive_power", caster, event.PassivePower)

	if ability.unit == nil then
		ability.target_unit = caster
		local unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
		unit:AddNewModifier(caster, nil, "modifier_invulnerable", {})
		local pid = ParticleManager:CreateParticle("particles/zeri_muse/muse_ability_base.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, unit)
		unit:SetHullRadius(0)

		local target_angle = 0
		Timers:CreateTimer(function()
			if unit:IsNull() then return nil end
			if not ability.target_unit:IsAlive() then
				SetTarget({caster = caster, target = caster, ability = ability})
			end
			target_angle = target_angle + 0.01
			local target_position = ability.target_unit:GetAbsOrigin() + Vector(math.cos(target_angle) * 100, math.sin(target_angle) * 100, 80)
			unit:SetAbsOrigin((unit:GetAbsOrigin() * 9 + target_position) / 10)

			if math_distance(caster, ability.target_unit) > 800 then
				ability.target_unit = caster
				ParticleManager:DestroyParticle(ability.pid, false)
			end

			ability:ApplyDataDrivenModifier(caster, ability.target_unit, "modifier_muse", {})

			local stats = {"power", "haste", "lifedrain", "armour", "magic_resistance" }

			for k, stat in ipairs(stats) do
				ability:ApplyDataDrivenModifier(caster, ability.target_unit, "modifier_muse_bonus_" .. stat, { Duration = 0.5 })
				ability.target_unit:SetModifierStackCount("modifier_muse_bonus_" .. stat, caster, 0)
				local base_stat = find_stat(caster, stat)
				if ability.target_unit == caster then
					ability.target_unit:SetModifierStackCount("modifier_muse_bonus_" .. stat, caster, base_stat * 0.15)
				else
					ability.target_unit:SetModifierStackCount("modifier_muse_bonus_" .. stat, caster, base_stat * 0.25)
				end
			end

			return 1 / 30
		end)
		ability.unit = unit
	end
end
function Die(event)
	local caster = event.caster
	local ability = event.ability
	
	if ability.unit ~= nil then
		ability.unit:Destroy()
		ability.unit = nil
	end

	if ability.target_unit ~= nil then
		ability.target_unit:RemoveModifierByName("modifier_muse")
		ability.target_unit = nil
		ability:ApplyDataDrivenModifier(caster, ability.target_unit, "modifier_muse", {})
	end

	if ability.pid ~= nil then
		ParticleManager:DestroyParticle(ability.pid, false)
	end
end