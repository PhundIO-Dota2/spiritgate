function create_coin( event )
	dofile("deal_damage")

	local ability = event.ability
	local caster = event.caster
	local damage_dealt = event.Damage
	local power_ratio = event.PowerRatio
	local coin = CreateUnitByName("npc_typhoon_riptide", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
	coin:AddNewModifier(caster, nil, "modifier_invulnerable", {})
	local pid = ParticleManager:CreateParticle("particles/merchant_princess/collateral.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, coin)
	coin:SetHullRadius(0)

	local multiplied = 0
	local angle = 0

	local isWaiting = false
	local isReturning = false

	local damage_dealt_to = { length = 0 }
	local damage_mult = 1

	local speed = 55
	local proj_offset = 0

	local fv = -(caster:GetAbsOrigin() - event.target_points[1]):Normalized()

	Timers:CreateTimer(function()
			if isReturning and not caster:IsAlive() then
				coin:Destroy()
				ParticleManager:DestroyParticle(pid, true)
				return nil
			end
			if coin:IsNull() then return nil end
			ParticleManager:SetParticleControl(pid, 0, GetGroundPosition(coin:GetAbsOrigin(), coin))

			local distance = caster:GetAbsOrigin() - coin:GetAbsOrigin()
			local direction = distance:Normalized()
			if isReturning and not isWaiting then 
				local x = -(direction * speed).x
				local y = -(direction * speed).y
				coin:SetAbsOrigin(coin:GetAbsOrigin() + Vector(x, y, 0))
				speed = speed - 1.2
				local friendlies = FindUnitsInRadius(caster:GetTeam(), coin:GetAbsOrigin(), nil, speed, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)

				for k, friendly_shaper in ipairs(friendlies) do
					if friendly_shaper == caster then
						coin:Destroy()
						ParticleManager:DestroyParticle(pid, true)
						return nil
					end
				end
			elseif not isWaiting then
				coin:SetAbsOrigin(coin:GetAbsOrigin() + (fv * speed))
				speed = speed - 2
			end
			coin:SetForwardVector(Vector(math.cos(angle), 0, math.sin(angle)))
			angle = angle + 2
			local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), coin:GetAbsOrigin(), nil, 100, 
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
					
					deal_damage(caster, nearby, damage_dealt * damage_mult, power_ratio, 1, caster:GetAbilityByIndex(0), false, false, true)
					damage_mult = math.max(0.6, damage_mult - 0.15)

					ability:ApplyDataDrivenModifier(caster, nearby, "modifier_pure_shaper_compound_interest_stack", {})
					nearby:SetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster, nearby:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) + 1)
					if nearby:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) >= 4 then
						nearby:RemoveModifierByName("modifier_pure_shaper_compound_interest_stack")
						dofile("deal_damage")
						deal_damage(caster, nearby, 20 + 80 * caster:GetLevel() / 20, 0.3, 1, event.ability, false, false, false)
					end 
					
					disable({
						caster = caster,
						target = nearby,
						ability = event.ability,
						Duration = 2,
						DisableModifier = "modifier_merchant_princess_collateral_slow"
					})
				end
			end
			return 1 / 30
		end
	)
	Timers:CreateTimer(0.7, function()
		isReturning = true
		isWaiting = true
		Timers:CreateTimer(0.05, function() 
			isWaiting = false
			speed = -10
			damage_dealt_to = { length = 0 }
			damage_mult = 1
		end)
	end)
	Timers:CreateTimer(10, function()
		if not coin:IsNull() then 
			coin:Destroy() 
			ParticleManager:DestroyParticle(pid, true)
		end
	end)
end