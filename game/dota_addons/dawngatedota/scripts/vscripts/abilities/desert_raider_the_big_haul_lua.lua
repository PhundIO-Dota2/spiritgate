function cast(event)
	dofile("deal_damage")

	local caster = event.caster
	local ability = event.ability
	local target_point = event.target_points[1]
	local origin_point = caster:GetAbsOrigin()

	ability:ApplyDataDrivenModifier(caster, caster, "modifier_big_haul_self_slow", {})

	local hook_pos = caster:GetAbsOrigin()
	local direction = (target_point - caster:GetAbsOrigin()):Normalized()
	local is_returning = false
	local spd = 30
	local targets = {}

	local pid = ParticleManager:CreateParticle("particles/kahgen_the_big_haul/the_big_haul_rope.vpcf", PATTACH_CUSTOMORIGIN, caster)

	Timers:CreateTimer(function()
		if is_returning then
			direction = -(hook_pos - caster:GetAbsOrigin()):Normalized()
			for k, target in ipairs(targets) do
				if math_distance(target:GetAbsOrigin(), hook_pos) < 150 then
					FindClearSpaceForUnit(target, hook_pos, true)
				end
			end
			if math_distance(hook_pos, caster:GetAbsOrigin()) < 75 then
				caster:RemoveModifierByName("modifier_big_haul_self_slow")
				for k, target in ipairs(targets) do
					target:RemoveModifierByName("modifier_big_haul_slow")
				end
				ParticleManager:DestroyParticle(pid, true)
				return
			end
		elseif math_distance(origin_point, hook_pos) > event.CastRange then
			is_returning = true
			spd = 55
		end
		if not is_returning then
			local found_targets = GetEnemiesInRadiusOfPoint(hook_pos, caster:GetTeamNumber(), 150)
			for k, target in ipairs(found_targets) do
				if not tableContains(targets, target) then
					targets[#targets + 1] = target
					ability:ApplyDataDrivenModifier(caster, target, "modifier_big_haul_slow", {})
					deal_damage(caster, target, event.Damage, event.DamagePowerRatio, 1, ability, false, false, true)
				end
			end
		end
		hook_pos = hook_pos + direction * spd
		local hook_part_pos = hook_pos - (target_point - origin_point):Normalized() * 200
		ParticleManager:SetParticleControl(pid, 1, hook_pos + Vector(0, 0, 50))
		ParticleManager:SetParticleControl(pid, 2, hook_part_pos)
		ParticleManager:SetParticleControl(pid, 0, caster:GetAbsOrigin() + Vector(0, 0, 50))
		ParticleManager:SetParticleControlForward(pid, 0, Vector((target_point - origin_point):Normalized().x, (target_point - origin_point):Normalized().y, 0))
		return 1 / 30
	end)
end