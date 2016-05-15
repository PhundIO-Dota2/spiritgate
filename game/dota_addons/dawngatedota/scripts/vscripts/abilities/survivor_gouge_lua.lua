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
			local damage_remaining = event.Damage / event.Duration / 30 * (event.Duration * 30 - ability.ticks_passed)
			local damage_remaining_power_ratio = damage_remaining / event.Damage * event.DamagePowerRatio 
			damage_remaining = damage_remaining + damage_remaining_power_ratio * find_stat(caster, "power")
			deal_damage(caster, target, damage_remaining + event.RecastDamage + event.RecastDamagePowerRatio * find_stat(caster, "power"), 0, 1, ability, false, false, false)
			ability.recast = false

			target:RemoveModifierByName("modifier_survivor_gouge_bleed")
			ability.target_unit = nil

			ParticleManager:DestroyParticle(ability.gouge_pid, false)
		end
	else
		ability.target_unit = target
		ability.ticks_passed = 0
		ability.recast = true
		ability.timer = Timers:CreateTimer(function()
			if caster:IsNull() or not caster:IsAlive() or ability.ticks_passed > event.Duration * 30 then 
				ability.target_unit = nil 
				ability.recast = false 
				ParticleManager:DestroyParticle(ability.gouge_pid, true)
				ability:StartCooldown(get_ability_cooldown(caster, ability))
				return 
			end
			ability.ticks_passed = ability.ticks_passed + 1
			deal_damage(caster, target, event.Damage / event.Duration / 30, event.DamagePowerRatio / event.Duration / 30, 1, ability, true, false, false)
			return 1 / 30
		end)
		ability:ApplyDataDrivenModifier(caster, target, "modifier_survivor_gouge_bleed", {})

		ability.gouge_pid =  ParticleManager:CreateParticle("particles/freia_gouge/gouge_ability_base.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)

		ability:EndCooldown()
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