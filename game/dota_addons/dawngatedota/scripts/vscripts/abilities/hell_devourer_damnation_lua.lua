function start(event)
	dofile("deal_damage")
	local caster = event.caster
	local ability = event.ability
	local radius = event.Radius
	local damage = event.Damage
	local powerRatio = event.PowerRatio
	local lifedrain = event.Lifedrain
	
	local done = false
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_hell_devourer_damnation_hidden", { })
	caster:SetModifierStackCount("modifier_hell_devourer_damnation_hidden", ability, lifedrain)

	local pid = ParticleManager:CreateParticle("particles/warlock_knight/damnation.vpcf", PATTACH_CUSTOMORIGIN, caster)

	Timers:CreateTimer(function()
		if not caster:IsAlive() then
			ParticleManager:DestroyParticle(pid, true)
			return nil
		end
		ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 10) - caster:GetForwardVector() * 20)
		local enemies = GetEnemiesInRadius(caster, radius)
		for k, enemy in ipairs(enemies) do
			deal_damage(caster, enemy, damage / 30 / 4, powerRatio / 30 / 4, 2, ability, false, false, true)
		end
		if done then return nil end
		return 1 / 30
	end)
	Timers:CreateTimer(4, function()
		done = true
		return nil
	end)
end