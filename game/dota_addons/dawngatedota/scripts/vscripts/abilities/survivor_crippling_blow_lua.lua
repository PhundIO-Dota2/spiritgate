function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local ability = event.ability
	local target = event.target
	local rage_ability = caster:FindAbilityByName("ability_rage_shaper")
	if ability.recast then
		if target == ability.target_unit and caster:GetModifierStackCount("modifier_rage_stack", rage_ability) >= event.RageRequirement then
			caster:SetModifierStackCount("modifier_rage_stack", rage_ability, caster:GetModifierStackCount("modifier_rage_stack", rage_ability) - 50)
			Timers:RemoveTimer(ability.timer)
			ability.recast = false
			ability.target_unit = nil

			disable({
				caster = caster,
				target = target,
				Duration = event.StunDuration,
				DisableModifier = "modifier_survivor_crippling_blow_stun",
				ability = ability,
			})
		end
	else
		ability.target_unit = target
		ability.recast = true
		ability.timer = Timers:CreateTimer(3, function()
			ability.target_unit = nil 
			ability.recast = false 
			ability:StartCooldown(get_ability_cooldown(caster, ability))
		end)
		disable({
			caster = caster,
			target = target,
			Duration = event.Duration,
			DisableModifier = "modifier_survivor_crippling_blow_slow",
			ability = ability,
		})
		ability:EndCooldown()
		deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, ablility, false, false, false)
	end
end
function precast( event )
    local caster = event.caster
    local target = event.target
    local player = caster:GetPlayerOwner()
    local pID = caster:GetPlayerOwnerID()
    local ability = event.ability

    -- This prevents the spell from going off
    if ability.recast and target ~= ability.target_unit then
        caster:Stop()
        EmitSoundOnClient("General.CastFail_InvalidTarget_Hero", player)
        
        Notifications:ClearBottom(pID)
        Notifications:Bottom(pID, {text="error_recast_different_target", duration=2, style={color="#E62020"}, continue=false})
    elseif ability.recast and target == ability.target_unit and caster:GetModifierStackCount("modifier_rage_stack", rage_ability) < event.RageRequirement then
        caster:Stop()
        EmitSoundOnClient("General.CastFail_InvalidTarget_Hero", player)

        Notifications:ClearBottom(pID)
        Notifications:Bottom(pID, {text="error_not_enough_rage", duration=2, style={color="#E62020"}, continue=false})
    end
end