function cast(event)
	local caster = event.caster
	local target_point = event.target_points[1]

	local fv = (target_point - caster:GetAbsOrigin()):Normalized()

	local pid = ParticleManager:CreateParticle("particles/kel_battlecry/battlecry_base.vpcf", PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 100))
	ParticleManager:SetParticleControl(pid, 1, caster:GetAbsOrigin() + fv * event.Radius + Vector(0, 0, 100))

	local hits = GetEnemiesInCone(caster, event.Radius, fv, 2)

	dofile("deal_damage")

	for _, v in pairs(hits) do
		deal_damage(caster, v, event.Damage, event.DamagePowerRatio, 1, event.ability, false, false, true)
		event.ability:ApplyDataDrivenModifier(caster, v, "modifier_battle_cry_reduced_movespeed_sheep", {})
		v:SetModifierStackCount("modifier_battle_cry_reduced_movespeed_sheep", caster, -event.MovespeedReduction)
		local stacks = -event.MovespeedReduction
		Timers:CreateTimer(function()
			v:SetModifierStackCount("modifier_battle_cry_reduced_movespeed_sheep", caster, v:GetModifierStackCount("modifier_battle_cry_reduced_movespeed_sheep", caster) + event.MovespeedReduction / 10)
			if v:GetModifierStackCount("modifier_battle_cry_reduced_movespeed_sheep", caster) < 1 then
				caster:RemoveModifierByName("modifier_battle_cry_reduced_movespeed_sheep")
				return
			end
			return 0.1
		end)
	end
end