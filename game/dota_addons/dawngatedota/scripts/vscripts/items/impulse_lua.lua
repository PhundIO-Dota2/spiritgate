function OnAttackLanded(event)
	local caster = event.caster
	local target = event.target
	caster:RemoveModifierByName("item_impulse_melee_dash")
	--caster:SetForceAttackTarget(nil)
	local item_impulse = find_item(caster, "item_impulse")
	item_impulse:ApplyDataDrivenModifier(caster, caster, "item_impulse_cooldown", {})
end
function ForceAttack(event)
	local caster = event.caster
	local target = event.target
	--caster:SetForceAttackTarget(caster:GetAttackTarget())
end
function OnOrder(event)
	local caster = event.caster
	if not caster:HasModifier("item_impulse_cooldown") then
		local enemy_target = event.target_entities[1]
		local item_impulse = find_item(caster, "item_impulse")

		if caster:IsRangedAttacker() then
			if enemy_target ~= nil then
				if math_distance(enemy_target, caster) < 230 then
					local dash_over = false
					local dash_direction = (caster:GetAbsOrigin() - enemy_target:GetAbsOrigin()):Normalized()
					Timers:CreateTimer(function()
						if dash_over then return end
						caster:SetAbsOrigin(caster:GetAbsOrigin() + dash_direction * 55)
						local estimated_pos = caster:GetAbsOrigin()
						FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true)
						if estimated_pos ~= caster:GetAbsOrigin() then 
							item_impulse:ApplyDataDrivenModifier(caster, caster, "item_impulse_cooldown", {}) 
							return 
						end
						return 1 / 30
					end)
					Timers:CreateTimer(0.15, function()
						dash_over = true
						item_impulse:ApplyDataDrivenModifier(caster, caster, "item_impulse_cooldown", {})
					end)
				end
			end
		else
			if enemy_target ~= nil then
				if enemy_target:GetTeamNumber() ~= caster:GetTeamNumber() and math_distance(enemy_target, caster) < 600 then
					item_impulse:ApplyDataDrivenModifier(caster, caster, "item_impulse_melee_dash", { Duration = math_distance(enemy_target, caster) / 1400 })
				end
			else
				if caster:HasModifier("item_impulse_melee_dash") then
					caster:RemoveModifierByName("item_impulse_melee_dash")
					item_impulse:ApplyDataDrivenModifier(caster, caster, "item_impulse_cooldown", {})
				end
			end
		end
	end
end