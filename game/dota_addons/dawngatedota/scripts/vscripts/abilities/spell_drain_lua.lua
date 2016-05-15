function cast(event)
	local caster = event.caster
	local target = event.target
	local ability = event.ability
	local universal_ability = caster:FindAbilityByName("ability_universal_ability")

	universal_ability:ApplyDataDrivenModifier(caster, target, "modifier_mortal_strike", {})
	ability:ApplyDataDrivenModifier(caster, target, "modifier_drain_taking_damage", {})

	local damage = (event.BaseDamage + event.DamagePerLevel * caster:GetLevel()) / 5

	dofile("deal_damage")

	local tick_damage = function()
		deal_damage(caster, target, damage, 0, 2, event.ability, true, false, false)
		Timers:CreateTimer(0.5, function()
			deal_damage_heal(caster, caster, damage * 0.9, 0, 0)
		end)
	end

	function do_particle(effect)
		local pid = ParticleManager:CreateParticle(effect, PATTACH_CUSTOMORIGIN, nil)
		local ticks_left = 60
		Timers:CreateTimer(function()
			ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
			ParticleManager:SetParticleControl(pid, 1, target:GetAbsOrigin() + Vector(0, 0, 100))
			ticks_left = ticks_left - 1
			if ticks_left <= 0 then
				return
			end
			return 1 / 30
		end)
	end
	do_particle("particles/spell_drain/drain_base.vpcf")

	ticks = 0

	Timers:CreateTimer(0.5, function()
		tick_damage()
		ticks = ticks + 1
		Timers:CreateTimer(1, function()
			ticks = ticks + 1

			do_particle("particles/spell_drain/drain_health.vpcf")
			tick_damage()

			if ticks == 5 then
				return
			end
			return 1
		end)
	end)
end