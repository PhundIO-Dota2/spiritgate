function waltz(event)
    dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local damage_dealt = event.Damage
	local direction = -(caster:GetAbsOrigin() - target):Normalized()
	local ticks_left = 7
	local done = false
	Timers:CreateTimer(function()
		ticks_left = ticks_left - 1
		if ticks_left == 0 then
			done = true
			return
		end
		caster:SetAbsOrigin(caster:GetAbsOrigin() + direction * 60)
		local last_pos = caster:GetAbsOrigin()
		FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
		if caster:GetAbsOrigin() ~= last_pos then
			done = true
			return
		end
		return 1 / 30
	end)
	local coins = 3
	Timers:CreateTimer(function()
		local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, 300, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
		if nearby_enemies[1] ~= nil then
			local nearby = nearby_enemies[1]
			coins = coins - 1
			if coins < 2 then
				damage_dealt = event.Damage / 2
			end
			throw_coin(caster, nearby, damage_dealt, event)
		end
		if coins == 0 or done then return end
		return 0.05
	end)
end

function throw_coin(caster, enemy, damage_dealt, event)
	local unit = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	local pid = ParticleManager:CreateParticle("particles/merchant_princess/waltz.vpcf", PATTACH_CUSTOMORIGIN, caster)
	local ability = event.ability

	Timers:CreateTimer(function()
		unit:SetAbsOrigin(unit:GetAbsOrigin() + -20 * (unit:GetAbsOrigin() - enemy:GetAbsOrigin()):Normalized())
		local distance = math_distance(unit, enemy)
		ParticleManager:SetParticleControl(pid, 0, unit:GetAbsOrigin() + Vector(0, 0, 100))
		if distance < 20 then
			unit:Destroy()
			ParticleManager:DestroyParticle(pid, true)
			deal_damage(caster, enemy, damage_dealt, event.PowerRatio, 1, caster:GetAbilityByIndex(2), false, false, true)
			ability:ApplyDataDrivenModifier(caster, enemy, "modifier_pure_shaper_compound_interest_stack", {})
			enemy:SetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster, enemy:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) + 1)
			if enemy:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) >= 4 then
				enemy:RemoveModifierByName("modifier_pure_shaper_compound_interest_stack")
				dofile("deal_damage")
				deal_damage(caster, enemy, 20 + 80 * caster:GetLevel() / 20, 0.3, 1, event.ability, false, false, false)
			end 
			return
		end
		return 1 / 30
	end)
end