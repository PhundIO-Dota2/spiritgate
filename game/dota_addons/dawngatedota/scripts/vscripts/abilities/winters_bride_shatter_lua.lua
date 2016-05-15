function cast(event)
	local caster = event.caster
	local target = event.target

	dofile("deal_damage")

	local stacks = target:GetModifierStackCount("modifier_ice_lance_slow_stack", caster)

	for i=0, stacks do
		Timers:CreateTimer(1 / 30 * i, function()
			local pid = ParticleManager:CreateParticle("particles/sakari_shatter/shatter_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
			local pos = caster:GetAbsOrigin()

			ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))

			local fv = -(pos - target:GetAbsOrigin()):Normalized()
			local velocity = fv * 10 + RandomVector(26)
			local spd = 30

			Timers:CreateTimer(function()
				fv = -(pos - target:GetAbsOrigin()):Normalized()
				pos = pos + velocity
				velocity = (velocity * 5 + fv * spd) / 6
				if (pos - target:GetAbsOrigin()):Length2D() < spd then
					ParticleManager:DestroyParticle(pid, false)
					if i == 0 then
						deal_damage(caster, target, event.Damage, 0, 2, event.ability, false, false, false)
						caster:FindAbilityByName("ability_frost_shaper"):ApplyDataDrivenModifier(caster, caster, "modifier_black_ice", {})
						caster:SetModifierStackCount("modifier_black_ice", caster, math.min(5, caster:GetModifierStackCount("modifier_black_ice", caster) + 1))
					else
						deal_damage(caster, target, event.StackDamage, event.StackDamagePowerRatio, 2, event.ability, false, false, false)
					end
					return
				end
				ParticleManager:SetParticleControl(pid, 0, pos + Vector(0, 0, 100))
				return 1 / 30
			end)
		end)
	end

	target:RemoveModifierByName("modifier_ice_lance_slow_stack")
	target:RemoveModifierByName("modifier_ice_lance_slow")
end