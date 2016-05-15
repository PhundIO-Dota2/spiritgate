function cast(event)
	local caster = event.caster

	if caster:GetHealth() <= event.HealthCost + 1 then 
		Timers:CreateTimer(function()
			event.ability:EndCooldown()
		end)
		return 
	end

	caster:SetHealth(caster:GetHealth() - event.HealthCost)

	local target = event.target
	local ability = event.ability

	ability:ApplyDataDrivenModifier(caster, target, "modifier_purifier_leeched_from", {})
	local pid = ParticleManager:CreateParticle("particles/viyanna_leech/leech_hit_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, target:GetAbsOrigin() + Vector(0, 0, 100))
	
	dofile("deal_damage")
	for i=1, 4 do
		Timers:CreateTimer(event.DamageDuration / 4 * i, function() 
			deal_damage(caster, target, event.Damage / 4, event.DamagePowerRatio / 4, 2, ability, true, false, false)
			local friendlies = GetFriendyHeroesInRadiusOfPointClosest(target:GetAbsOrigin(), caster:GetTeamNumber(), 1200)
			if #friendlies >= 1 then
				local shield_target = friendlies[1]
				ability:ApplyDataDrivenModifier(caster, shield_target, "modifier_purifier_leech_shield", {})
				shield_target:SetModifierStackCount("modifier_purifier_leech_shield", caster, shield_target:GetModifierStackCount("modifier_purifier_leech_shield", caster) + event.Shield + caster:GetMaxHealth() * event.ShieldHealthRatio)
				local new_cooldown = ability:GetCooldownTimeRemaining() - 0.5
				ability:EndCooldown()
				if new_cooldown > 0 then
					ability:StartCooldown(new_cooldown)
				end
			end
		end)
	end
end