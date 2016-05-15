function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability

	local pid = ParticleManager:CreateParticle("particles/spell_stagger/stagger_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	local pos = caster:GetAbsOrigin()

	local disable_duration = math.min(event.MaximumDuration, event.MinimumDuration + (event.MaximumDuration - event.MinimumDuration) * (caster:GetAbsOrigin() - target:GetAbsOrigin()):Length2D() / event.Radius)

	Timers:CreateTimer(function()
		local fv = -(pos - target:GetAbsOrigin()):Normalized()
		pos = pos + fv * 40
		ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))

		if (pos - target:GetAbsOrigin()):Length2D() <= 30 then
			ParticleManager:DestroyParticle(pid, false)
			local pid2 = ParticleManager:CreateParticle("particles/spell_stagger/stagger_hit.vpcf", PATTACH_CUSTOMORIGIN, nil)
			ParticleManager:SetParticleControl(pid2, 0, target:GetAbsOrigin() + Vector(0, 0, 100))

			dofile("deal_damage")
			deal_damage(caster, target, event.BaseDamage + event.DamagePerLevel * caster:GetLevel(), 0, 1, ability, false, false, false)

			ability:ApplyDataDrivenModifier(caster, target, "modifier_staggered", {Duration = disable_duration})

			local stacks = math.abs(event.MovementSpeedReduction)
			local ticks = disable_duration * 10
			local stacks_lost_per_tick = stacks / ticks

			target:SetModifierStackCount("modifier_staggered", caster, stacks)

			Timers:CreateTimer(function()
				stacks = stacks - stacks_lost_per_tick
				ticks = ticks - 1
				target:SetModifierStackCount("modifier_staggered", caster, math.ceil(stacks))
				if ticks <= 0 then
					return
				end
				return 1 / 10
			end)

			return
		end

		return 1 / 30
	end)
end