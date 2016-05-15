function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local damage_per_second = event.DamagePerSecond
	local damage_per_second_power_ratio = event.DamagePerSecondPowerRatio
	local shield_per_second = event.ShieldPerSecond + find_stat(caster, "power") * event.ShieldPerSecondPowerRatio

	local universal_ability = caster:FindAbilityByName("ability_universal_ability")

	local revolt_ability = caster:FindAbilityByName("ability_enforcer_revolt")
	revolt_ability:ApplyDataDrivenModifier(caster, caster, "modifier_revolt_bold", {})

	local shield_maximum = event.ShieldMaximum + find_stat(caster, "power") * event.ShieldMaximumPowerRatio

	local targets = GetEnemiesInRadiusOfPoint(caster:GetAbsOrigin(), caster:GetTeamNumber(), event.Radius)
	local target_pids = {}

	for k, target in pairs(targets) do
		if target.is_jungle_creep or target:IsHero() then
			event.ability:ApplyDataDrivenModifier(caster, target, "modifier_enforcer_unbreakable_slow", {})
			target_pids[k] = ParticleManager:CreateParticle("particles/basko_unbreakable/unbreakable_chain.vpcf", PATTACH_CUSTOMORIGIN, nil)
		end
	end

	local frames_spent = 0

	local total_shield = 0

	local pid = ParticleManager:CreateParticle("particles/basko_unbreakable/unbreakable_base.vpcf", PATTACH_CUSTOMORIGIN, caster)

	Timers:CreateTimer(function()
		for k, target in pairs(targets) do
			if target.is_jungle_creep or target:IsHero() then
				if not target:HasModifier("modifier_enforcer_unbreakable_slow") or math_distance(caster, target) > 580 then
					target:RemoveModifierByName("modifier_enforcer_unbreakable_slow")
					ParticleManager:DestroyParticle(target_pids[k], true)
					table.remove(target_pids, k)
					table.remove(targets, k)
				else
					ParticleManager:SetParticleControl(target_pids[k], 0, caster:GetAbsOrigin())
					ParticleManager:SetParticleControl(target_pids[k], 1, target:GetAbsOrigin())
					if frames_spent % 30 == 0 then
						universal_ability:ApplyDataDrivenModifier(caster, caster, "modifier_min_jungle_shield", {Duration = 2})
						caster:SetModifierStackCount("modifier_min_jungle_shield", caster, caster:GetModifierStackCount("modifier_min_jungle_shield", caster) + shield_per_second)
						total_shield = total_shield + shield_per_second
						if total_shield > shield_maximum - shield_per_second then
							shield_per_second = math.max(0, shield_maximum - total_shield)
						end
						deal_damage(caster, target, damage_per_second, damage_per_second_power_ratio, 1, event.ability, true, false, true)
					end
				end
			end
		end
		frames_spent = frames_spent + 1
		ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 90))
		if frames_spent > 30 * 4 or #targets == 0 or not caster:IsAlive() then 
			for k, target in pairs(targets) do
				if target.is_jungle_creep or target:IsHero() then
					target:RemoveModifierByName("modifier_enforcer_unbreakable_slow")
					ParticleManager:DestroyParticle(target_pids[k], true)
				end
			end
			ParticleManager:DestroyParticle(pid, true)
			return 
		end
		return 1 / 30
	end)
end