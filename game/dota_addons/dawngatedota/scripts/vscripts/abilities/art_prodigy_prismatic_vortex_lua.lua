function StartSpell(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local done = false

	ability:ApplyDataDrivenModifier(target, target, "modifier_prismatic_vortex_health", {})
	target:SetModifierStackCount("modifier_prismatic_vortex_health", target, event.Health + find_stat(caster, "power") * event.HealthPowerRatio)

	Timers:CreateTimer(function()
		if done then return nil end
		local enemies = GetEnemiesInRadius(target, event.DrainRadius)
		local power_bonus = 0
		for k, enemy in ipairs(enemies) do
			if enemy:IsHero() then
				local power_drain = event.ShaperPowerDrain + find_stat(caster, "power") * event.ShaperPowerDrainPowerRatio
				power_bonus = power_bonus + power_drain
				ability:ApplyDataDrivenModifier(target, enemy, "modifier_prismatic_vortex_power_loss", {})
				enemy:SetModifierStackCount("modifier_prismatic_vortex_power_loss", target, power_drain)
			else
				power_bonus = power_bonus + event.MinionPowerDrain
				ability:ApplyDataDrivenModifier(target, enemy, "modifier_prismatic_vortex_power_loss", {})
				enemy:SetModifierStackCount("modifier_prismatic_vortex_power_loss", target, event.MinionPowerDrain)
			end
		end
		if power_bonus > 0 then
			ability:ApplyDataDrivenModifier(target, target, "modifier_prismatic_vortex_power_gain", {})
			target:SetModifierStackCount("modifier_prismatic_vortex_power_gain", target, power_bonus)
		end
		return 1 / 30
	end)
	Timers:CreateTimer(event.Duration, function()
		done = true
	end)
end