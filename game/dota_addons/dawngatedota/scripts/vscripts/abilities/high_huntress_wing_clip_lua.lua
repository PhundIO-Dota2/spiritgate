function cast(event)
	dofile("deal_damage")
	local caster = event.caster
	local target = event.target_points[1]
	local flying_birraga = create_dummy(caster)
	local pid = ParticleManager:CreateParticle("particles/nissa_wing_clip/wing_clip_ability_base.vpcf", PATTACH_CUSTOMORIGIN, flying_birraga)
	Timers:CreateTimer(function()
		local fv = (target - flying_birraga:GetAbsOrigin()):Normalized()
		flying_birraga:SetAbsOrigin(flying_birraga:GetAbsOrigin() + fv * 30)
		ParticleManager:SetParticleControl(pid, 0, flying_birraga:GetAbsOrigin() + Vector(0, 0, 60))
		if math_distance(flying_birraga:GetAbsOrigin(), target) < 30 then
			ParticleManager:DestroyParticle(pid, true)
			pid = ParticleManager:CreateParticle("particles/nissa_wing_clip/wing_clip_ability_base.vpcf", PATTACH_CUSTOMORIGIN, flying_birraga)
			Timers:CreateTimer(0.01, function()
				if flying_birraga:IsNull() then return end
				ParticleManager:SetParticleControl(pid, 0, flying_birraga:GetAbsOrigin() + Vector(0, 0, 30))
				local targets = GetEnemiesInRadiusOf(caster, flying_birraga, event.Radius, DEBUG)
				for k, target in ipairs(targets) do
					event.ability:ApplyDataDrivenModifier(caster, target, "modifier_wing_clip_slow", {})
					deal_damage(caster, target, event.Damage / 8, event.DamagePowerRatio / 8, 1, event.ability, true, false, true)
				end
				return 0.5
			end)
			Timers:CreateTimer(event.Duration + 0.25, function()
				flying_birraga:Destroy()
			end)
			return
		end
		return 1 / 30
	end)
end