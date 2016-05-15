dofile("deal_damage")

function create_coins( event )
	local caster = event.caster
	local damage_dealt = event.Damage
	local target = event.target
	local power_ratio = event.PowerRatio
	local ability = event.ability
	Timers:CreateTimer(1, function()
		for i = 1, event.Coins do
			Timers:CreateTimer((i - 1) / 6, function()
				if caster:IsChanneling() then
					EmitSoundOn("dawngatedota.merchant_princess_FinalPaymentCoin", caster)
					local coin = CreateUnitByName("npc_merchant_princess_collateral_coin", caster:GetAbsOrigin(), false, caster, caster, caster:GetTeamNumber())
					coin:AddNewModifier(caster, nil, "modifier_invulnerable", {})
					Physics:Unit(coin)
					coin:FollowNavMesh(nil)
					coin:SetAutoUnstuck(false) 
					coin:SetNavCollisionType (PHYSICS_NAV_NOTHING) 
					local unit_velocity = math_unit_vector_between_units(caster, target)
		            coin:SetPhysicsVelocity(unit_velocity * 1800)
					local multiplied = 0
					local angle = 0
					coin:SetHullRadius(0)
					Timers:CreateTimer(function()
							if coin:IsNull() then return nil end
							local distance = target:GetAbsOrigin() - coin:GetAbsOrigin()
							local direction = distance:Normalized()
							coin:SetPhysicsVelocity(direction * 1800)
		                    coin:SetForwardVector(Vector(math.cos(angle), 0, math.sin(angle)))
							angle = angle + 2
							local nearby_enemies = FindUnitsInRadius(caster:GetTeam(), coin:GetAbsOrigin(), nil, 50, 
								DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
							for i, nearby in ipairs(nearby_enemies) do
								deal_damage(caster, nearby, damage_dealt / event.Coins, power_ratio, 1, caster:GetAbilityByIndex(0), false, false, false)
								ability:ApplyDataDrivenModifier(caster, target, "modifier_pure_shaper_compound_interest_stack", {})
								target:SetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster, target:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) + 1)
								if target:GetModifierStackCount("modifier_pure_shaper_compound_interest_stack", caster) >= 4 then
									target:RemoveModifierByName("modifier_pure_shaper_compound_interest_stack")
									dofile("deal_damage")
									deal_damage(caster, target, 20 + 80 * caster:GetLevel() / 20, 0.3, 1, event.ability, false, false, false)
								end 
								Timers:CreateTimer(1 / 30, function() if coin:IsNull() then return else coin:Destroy() end end)
								return nil
							end
							return 1 / 30
						end
					)
					Timers:CreateTimer(3, function()
							if not coin:IsNull() then coin:Destroy() end
						end
					)
				end
			end)
		end
	end)
end